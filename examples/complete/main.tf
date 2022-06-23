resource "aws_iam_role" "lambda" {
  name               = "${local.name}-iam-role-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
resource "aws_iam_policy_attachment" "lambda" {
  name       = "${local.name}-lambda"
  roles      = [aws_iam_role.lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}



resource "aws_iam_policy" "mysql_lambda_policy" {
  name   = "${local.name}-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.mysql_lambda_policy.json
}


resource "aws_iam_policy_attachment" "mysql_lambda_policy" {
  name       = "${local.name}-policy-attachment"
  roles      = [aws_iam_role.lambda.name]
  policy_arn = aws_iam_policy.mysql_lambda_policy.arn
}
/*
resource "aws_iam_role_policy_attachment" "lambda-vpc" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}*/

resource "aws_lambda_function" "sample_mysql" {
  #checkov:skip=CKV_AWS_117: "Ensure that AWS Lambda function is configured inside a VPC"
  #checkov:skip=CKV_AWS_116: "Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
  filename                       = local.filename
  function_name                  = "${local.name}-rotation"
  handler                        = "lambda_function.lambda_handler"
  runtime                        = "python3.9"
  role                           = aws_iam_role.lambda.arn
  description                    = "AWS SecretsManager secret rotation for RDS MySQL using single user."
  source_code_hash = data.archive_file.lambda.output_base64sha256
  timeout     = 60
  kms_key_arn = aws_kms_key.lambda.arn
  reserved_concurrent_executions = 3
  tracing_config {
    mode = "Active"
  }
/*  vpc_config {
    subnet_ids         = ["subnet-0a1af318e7780f781", "subnet-07b89216ed1d30b62", "subnet-0bbc73f8db9bf36d8",]
    security_group_ids = [ aws_security_group.mysql.id ]
  }*/

  environment {
    variables = {
      SECRETS_MANAGER_ENDPOINT = "https://secretsmanager.${data.aws_region.current.name}.amazonaws.com"
    }
  }
}

resource "aws_lambda_permission" "default" {
  function_name = aws_lambda_function.sample_mysql.function_name
  statement_id  = "AllowExecutionSecretManager"
  action        = "lambda:InvokeFunction"
  principal     = "secretsmanager.amazonaws.com"
}

resource "aws_kms_key" "lambda" {
  description         = "Key for lambda environment variables"
  enable_key_rotation = true
}

resource "aws_kms_alias" "lambda" {
  name          = "alias/${local.name}"
  target_key_id = aws_kms_key.lambda.key_id
}

module "secret_rotation" {
  source                                = "./../../"
  name                                  = local.name
  description                           = "Example complete secret with rotation"
  kms_key_id                            = data.aws_kms_alias.secretsmanager.target_key_arn
  enable_secretsmanager_secret_rotation = true
  secret_policy                         = local.policy
  automatically_after_days              = 7
  rotation_lambda_arn                   = aws_lambda_function.sample_mysql.arn
  secrets = {
  secret1 = {
      secret_string = jsonencode(
        {
          engine   = "mysql"
          host     = aws_db_instance.mysql.address
          username = "admin"
          password = random_password.mysql_password.result
          dbname   = "randominstancemysql"
          port     = "3306"
      })
    }
  }
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}
