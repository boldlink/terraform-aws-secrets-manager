data "aws_region" "current" {}

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

resource "aws_iam_role" "lambda" {
  name               = "${var.function_name}-${data.aws_region.current.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_lambda_function" "sample-mysql" {
    filename         = "secrets_manager_rotation.zip"
    function_name    = "secrets-manager-rotation"
    handler          = "secrets_manager_rotation.lambda_handler"
    runtime          = "python3.7"
    source_code_hash = filebase64sha256("${path.module}/secrets_manager_rotation.zip")  
}


module "secretmanager_secret" {
    enable_secretsmanager_secret_policy = true
    kms_key_id = data.aws_kms_alias.secretsmanager.target_key_arn
    name = "samplesecret"
    policy =  <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "EnableAnotherAWSAccountToReadTheSecret",
                "Effect": "Allow",
                "Principal": {
                  "AWS": "arn:aws:iam::123456789012:root"
                },
                "Action": "secretsmanager:GetSecretValue",
                "Resource": "*"
            }
          ]
        }
    POLICY
  
}