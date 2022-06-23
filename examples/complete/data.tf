data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}


data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "mysql-lambda"
  output_path = local.filename
}

data "aws_kms_alias" "secretsmanager" {
  name = "alias/aws/secretsmanager"
}

data "aws_vpc" "app01" {
  id = "vpc-00451fe53255ef46d" 
}

data "aws_vpc" "default" {
  default = true 
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = ["vpc-00451fe53255ef46d" ]
  }
  tags = {
    "Name" = "app01.pub*"
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "mysql_lambda_policy" {
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DetachNetworkInterface",
    ]
    resources = ["*", ]
  }
  statement {
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecretVersionStage",
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:*",
    ]
  }
  statement {
    actions   = ["secretsmanager:GetRandomPassword"]
    resources = ["*", ]
  }
}