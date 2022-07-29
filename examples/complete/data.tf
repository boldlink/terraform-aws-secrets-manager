data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "mysql-lambda"
  output_path = local.filename
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    sid     = "GrantAssumeRolePermission"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "monitoring" {
  statement {
    sid = "GrantAssumeRolePermission"
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}
