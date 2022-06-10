data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_kms_alias" "secretsmanager" {
  name = "alias/aws/secretsmanager"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "secrets_manager_rotation"
  output_path = local.filename
}
