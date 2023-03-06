locals {
  account_id       = data.aws_caller_identity.current.account_id
  partition        = data.aws_partition.current.partition
  region           = data.aws_region.current.name
  private_subnets  = [cidrsubnet(var.cidr_block, 8, 1), cidrsubnet(var.cidr_block, 8, 2), cidrsubnet(var.cidr_block, 8, 3)]
  isolated_subnets = [cidrsubnet(var.cidr_block, 8, 10), cidrsubnet(var.cidr_block, 8, 11), cidrsubnet(var.cidr_block, 8, 13)]
  azs              = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
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
}
