
provider "aws" {
  region = "eu-west-1"
}

resource "aws_iam_role" "lambda" {
  name               = "${local.name}-iam-role-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
resource "aws_lambda_function" "sample_mysql" {
  filename                       = local.filename
  function_name                  = "secrets-manager-rotation"
  handler                        = "secrets_manager_rotation.lambda_handler"
  runtime                        = "python3.7"
  role                           = aws_iam_role.lambda.arn
  description                    = "AWS SecretsManager secret rotation for RDS MySQL using single user."
  source_code_hash               = filebase64sha256("${path.module}/${local.filename}")
  reserved_concurrent_executions = 0
  tracing_config {
    mode = "Active"
  }
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
}
