resource "aws_lambda_function" "mysql" {
  #checkov:skip=CKV_AWS_116: "Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
  #checkov:skip=CKV_AWS_272: "Ensure AWS Lambda function is configured to validate code-signing"
  filename                       = var.filename
  function_name                  = "${var.name}-rotation"
  handler                        = "lambda_function.lambda_handler"
  runtime                        = var.runtime
  role                           = aws_iam_role.lambda.arn
  description                    = var.function_description
  source_code_hash               = data.archive_file.lambda.output_base64sha256
  timeout                        = var.timeout
  kms_key_arn                    = module.kms.arn
  reserved_concurrent_executions = var.reserved_concurrent_executions
  tracing_config {
    mode = var.mode
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
  tags = merge(
    { Name = var.name },
  var.tags)
}

resource "aws_lambda_permission" "default" {
  function_name = aws_lambda_function.mysql.function_name
  statement_id  = "AllowExecutionSecretManager"
  action        = "lambda:InvokeFunction"
  principal     = "secretsmanager.amazonaws.com"
}

resource "aws_iam_role" "lambda" {
  name               = "${var.name}-iam-role-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_vpc" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_policy_attachment" "lambda" {
  name       = "${var.name}-lambda"
  roles      = [aws_iam_role.lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "mysql_lambda_policy" {
  name   = "${var.name}-policy"
  path   = "/"
  policy = local.lambda_policy
}

resource "aws_iam_policy_attachment" "mysql_lambda_policy" {
  name       = "${var.name}-policy-attachment"
  roles      = [aws_iam_role.lambda.name]
  policy_arn = aws_iam_policy.mysql_lambda_policy.arn
}
