resource "aws_iam_role" "lambda" {
  name               = "${local.name}-iam-role-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
resource "aws_lambda_function" "sample_mysql" {
  #checkov:skip=CKV_AWS_117: "Ensure that AWS Lambda function is configured inside a VPC"
  #checkov:skip=CKV_AWS_116: "Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
  filename                       = local.filename
  function_name                  = "${local.name}-rotation"
  handler                        = "secrets_manager_rotation.lambda_handler"
  runtime                        = "python3.7"
  role                           = aws_iam_role.lambda.arn
  description                    = "AWS SecretsManager secret rotation for RDS MySQL using single user."
  source_code_hash               = data.archive_file.lambda.output_base64sha256
  reserved_concurrent_executions = 0
  tracing_config {
    mode = "Active"
  }
  depends_on = [
    data.archive_file.lambda
  ]
}

resource "aws_lambda_permission" "default" {
  function_name = aws_lambda_function.sample_mysql.function_name
  statement_id  = "AllowExecutionSecretManager"
  action        = "lambda:InvokeFunction"
  principal     = "secretsmanager.amazonaws.com"
}

resource "random_password" "rds_password" {
  length  = 16
  special = false
}

module "secret_rotation" {
  source                                = "./../../"
  name                                  = "${local.name}-rotation"
  description                           = "Example complete secet with rotation"
  kms_key_id                            = data.aws_kms_alias.secretsmanager.target_key_arn
  enable_secretsmanager_secret_rotation = true
  secret_policy                         = local.policy
  rotation_lambda_arn                   = aws_lambda_function.sample_mysql.arn
  secrets = {
    secret1 = {
      secret_string = jsonencode(
        {
          username = "admin"
          password = random_password.rds_password.result
          engine   = "mysql"
          port     = "3306"
      })
    }
  }
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}
