provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}

data "aws_kms_alias" "secretsmanager" {
  name = "alias/aws/secretsmanager"
}

resource "random_password" "rds_password" {
  length  = 16
  special = false
}

module "key_pair_string" {
  source                               = "./../../"
  name                                 = "sample-secret-key_pair"
  description                          = "this is a key_pair secret example "
  kms_key_id                           = data.aws_kms_alias.secretsmanager.target_key_arn
  enable_secretsmanager_secret_version = true
  secrets = {
    key_pair1 = {
      secret_string = jsonencode(
        {
          username = "test"
          password = "${random_password.rds_password.result}"
        }
      )
    }
  }
  enable_secretsmanager_secret_policy = true
  policy                              = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "EnablePermissions",
          "Effect": "Allow",
          "Principal": {
            "AWS": "${data.aws_caller_identity.current.arn}"
          },         
          "Action": "secretsmanager:GetSecretValue",
          "Resource": "*"
        }
      ]
    }
    POLICY 
}
