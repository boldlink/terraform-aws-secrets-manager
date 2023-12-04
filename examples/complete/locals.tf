locals {
  account_id          = data.aws_caller_identity.current.account_id
  partition           = data.aws_partition.current.partition
  region              = data.aws_region.current.name
  internal_subnet_ids = data.aws_subnets.internal.ids
  internal_subnets    = [cidrsubnet(var.cidr_block, 8, 1), cidrsubnet(var.cidr_block, 8, 2), cidrsubnet(var.cidr_block, 8, 3)]
  layer_filename = "./mysql-lambda/zip.tmp/pymysql.zip"
  function_filename = "./mysql-lambda/zip.tmp/${var.filename}"
  additional_lambda_permissions = {
    statement1 = {
      sid    = "Allowec2Actions"
      effect = "Allow"
      actions = [
        "ec2:DescribeInstances",
        "ec2:StopInstances",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:AttachNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:AssignPrivateIpAddresses",
        "ec2:UnassignPrivateIpAddresses"
      ]
      resources = ["*"]
    },
    statement2 = {
      sid    = "GiveSpecificSecretPermissions",
      effect = "Allow",
      actions = [
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetSecretValue",
        "secretsmanager:PutSecretValue",
        "secretsmanager:UpdateSecretVersionStage",
      ],
      resources = [
        "arn:${local.partition}:secretsmanager:${local.region}:${local.account_id}:secret:*",
      ]
    },
    statement3 = {
      sid       = "AllowGetRandomPassword",
      actions   = ["secretsmanager:GetRandomPassword"],
      effect    = "Allow",
      resources = ["*"]
    }
  }
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
}
