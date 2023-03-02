locals {
  account_id       = data.aws_caller_identity.current.account_id
  partition        = data.aws_partition.current.partition
  region           = data.aws_region.current.name
  name             = "example-complete-secret"
  filename         = "mysql-lambda.zip"
  cidr_block       = "192.168.0.0/16"
  private_subnets  = [cidrsubnet(local.cidr_block, 8, 1), cidrsubnet(local.cidr_block, 8, 2), cidrsubnet(local.cidr_block, 8, 3)]
  isolated_subnets = [cidrsubnet(local.cidr_block, 8, 10), cidrsubnet(local.cidr_block, 8, 11), cidrsubnet(local.cidr_block, 8, 13)]
  az1              = data.aws_availability_zones.available.names[0]
  az2              = data.aws_availability_zones.available.names[1]
  az3              = data.aws_availability_zones.available.names[2]
  azs              = [local.az1, local.az2, local.az3]
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
    Environment        = "examples"
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "Example"
    LayerId            = "Example"
  }
}
