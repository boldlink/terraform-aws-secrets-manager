resource "aws_lambda_function" "mysql" {
  #checkov:skip=CKV_AWS_116: "Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
  filename                       = local.filename
  function_name                  = "${local.name}-rotation"
  handler                        = "lambda_function.lambda_handler"
  runtime                        = "python3.9"
  role                           = aws_iam_role.lambda.arn
  description                    = "AWS SecretsManager secret rotation for RDS MySQL using single user."
  source_code_hash               = data.archive_file.lambda.output_base64sha256
  timeout                        = 60
  kms_key_arn                    = aws_kms_key.lambda.arn
  reserved_concurrent_executions = 3
  tracing_config {
    mode = "Active"
  }
  vpc_config {
    subnet_ids         = flatten(module.rotation_vpc.private_subnet_id)
    security_group_ids = [aws_security_group.lambda.id]
  }

  environment {
    variables = {
      SECRETS_MANAGER_ENDPOINT = "https://secretsmanager.${data.aws_region.current.name}.amazonaws.com"
    }
  }
}

resource "aws_lambda_permission" "default" {
  function_name = aws_lambda_function.mysql.function_name
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

resource "aws_iam_role" "lambda" {
  name               = "${local.name}-iam-role-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_vpc" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
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
