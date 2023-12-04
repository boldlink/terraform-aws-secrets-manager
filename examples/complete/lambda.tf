resource "null_resource" "pymysql" {
  provisioner "local-exec" {
    command = "pip3 install pymysql -t mysql-lambda/libraries/python.tmp/python --upgrade"
  }
}

module "lambda" {
  source  = "boldlink/lambda/aws"
  version = "1.1.0"
  #checkov:skip=CKV_AWS_50:X-ray tracing is enabled for Lambda
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  function_name                 = "${var.name}-rotation"
  description                   = var.function_description
  filename                      = local.function_filename
  handler                       = "lambda_function.lambda_handler"
  runtime                       = var.runtime
  source_code_hash              = data.archive_file.lambda.output_base64sha256
  additional_lambda_permissions = local.additional_lambda_permissions
  kms_key_arn                   = module.kms.arn
  timeout                       = var.timeout
  tags                          = merge({ Name = var.name }, var.tags)
  lambda_permissions = [
    {
      statement_id = "AllowExecutionSecretManager"
      action       = "lambda:InvokeFunction"
      principal    = "secretsmanager.amazonaws.com"
    }
  ]

  layers = [
    {
      filename            = local.layer_filename
      layer_name          = "pymysql"
      compatible_runtimes = ["python3.9"]
      source_code_hash    = data.archive_file.pymysql.output_base64sha256
    }
  ]

  environment = {
    variables = {
      SECRETS_MANAGER_ENDPOINT = "https://secretsmanager.${local.region}.amazonaws.com"
    }
  }

  subnet_ids            = flatten(local.internal_subnet_ids)
  security_group_ids    = [aws_security_group.lambda.id]
  create_security_group = var.create_lambda_security_group
  vpc_id                = module.secretsmanager_vpc.vpc_id
  tracing_config = {
    mode = var.mode
  }
  depends_on = [null_resource.pymysql]
}
