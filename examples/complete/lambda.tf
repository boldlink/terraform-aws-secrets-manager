resource "aws_lambda_function" "mysql" {
  #checkov:skip=CKV_AWS_116: "Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
  #checkov:skip=CKV_AWS_272: "Ensure AWS Lambda function is configured to validate code-signing"
  filename                       = local.filename
  function_name                  = "${local.name}-rotation"
  handler                        = "lambda_function.lambda_handler"
  runtime                        = "python3.9"
  role                           = aws_iam_role.lambda.arn
  description                    = "AWS SecretsManager secret rotation for RDS MySQL using single user."
  source_code_hash               = data.archive_file.lambda.output_base64sha256
  timeout                        = 60
  kms_key_arn                    = module.lambda_kms.arn
  reserved_concurrent_executions = 3
  tracing_config {
    mode = "Active"
  }
  vpc_config {
    subnet_ids         = flatten(module.vpc.private_subnet_id)
    security_group_ids = [aws_security_group.lambda.id]
  }

  environment {
    variables = {
      SECRETS_MANAGER_ENDPOINT = "https://secretsmanager.${data.aws_region.current.name}.amazonaws.com"
    }
  }
  tags = local.tags
}

resource "aws_lambda_permission" "default" {
  function_name = aws_lambda_function.mysql.function_name
  statement_id  = "AllowExecutionSecretManager"
  action        = "lambda:InvokeFunction"
  principal     = "secretsmanager.amazonaws.com"
}

module "lambda_kms" {
  source              = "boldlink/kms/aws"
  version             = "1.1.0"
  description         = "key for secrets lambda function"
  create_kms_alias    = true
  enable_key_rotation = true
  alias_name          = "alias/${local.name}-lamdba-key"
  tags                = local.tags
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
  policy = local.lambda_policy
}

resource "aws_iam_policy_attachment" "mysql_lambda_policy" {
  name       = "${local.name}-policy-attachment"
  roles      = [aws_iam_role.lambda.name]
  policy_arn = aws_iam_policy.mysql_lambda_policy.arn
}
