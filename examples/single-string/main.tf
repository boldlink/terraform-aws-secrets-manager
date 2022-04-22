provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}

data "aws_kms_alias" "secretsmanager" {
  name = "alias/aws/secretsmanager"
}

module "single_string" {
  source                               = "./../../"
  name                                 = "sample-secret-single"
  description                          = "this is a single secret example "
  kms_key_id                           = data.aws_kms_alias.secretsmanager.target_key_arn
  enable_secretsmanager_secret_version = true
  secrets = {
    single_string = {
      secret_string = "SampleStringToProtect"
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