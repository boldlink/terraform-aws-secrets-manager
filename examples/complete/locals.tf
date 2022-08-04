locals {
  account_id       = data.aws_caller_identity.current.account_id
  partition        = data.aws_partition.current.partition
  region           = data.aws_region.current.name
  name             = "example-complete-secret"
  filename         = "mysql-lambda.zip"
  cidr_block       = "192.168.0.0/16"
  tag_env          = "dev"
  rotation_subnet1 = cidrsubnet(local.cidr_block, 7, 50)
  rotation_subnet2 = cidrsubnet(local.cidr_block, 7, 60)
  rotation_subnet3 = cidrsubnet(local.cidr_block, 7, 70)
  rotation_subnets = [local.rotation_subnet1, local.rotation_subnet2, local.rotation_subnet3]

  az1 = data.aws_availability_zones.available.names[0]
  az2 = data.aws_availability_zones.available.names[1]
  az3 = data.aws_availability_zones.available.names[2]
  azs = [local.az1, local.az2, local.az3]
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid    = "GetSecretValuePermission",
          Effect = "Allow",
          Principal = {
            AWS = "arn:${local.partition}:iam::${local.account_id}:root"
          },
          Action   = "secretsmanager:GetSecretValue",
          Resource = "*"
        }
      ]
  })
  lambda_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "GiveSpecificNetworkInterfacePermissions",
        Effect = "Allow",
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DetachNetworkInterface",
        ],
        Resource = ["*"]
      },
      {
        Sid    = "GiveSpecificSecretPermissions",
        Effect = "Allow",
        Action = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecretVersionStage",
        ],
        Resource = [
          "arn:${local.partition}:secretsmanager:${local.region}:${local.account_id}:secret:*",
        ]
      },
      {
        Sid      = "AllowGetRandomPassword",
        Action   = ["secretsmanager:GetRandomPassword"],
        Effect   = "Allow",
        Resource = ["*"]
    }]
  })
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}
