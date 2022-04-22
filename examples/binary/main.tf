provider "aws" {
  region = "eu-west-1"
}
locals {
  filename = "test.txt"
}
data "aws_caller_identity" "current" {}

data "aws_kms_alias" "secretsmanager" {
  name = "alias/aws/secretsmanager"
}

module "binary_string" {
  source                               = "./../../"
  name                                 = "sample-secret-binary2"
  description                          = "this is a binary secret example "
  kms_key_id                           = data.aws_kms_alias.secretsmanager.target_key_arn
  enable_secretsmanager_secret_version = true
  secrets = {
    secret1 = {
      secret_binary = base64encode(file("${path.module}/${local.filename}")) #file("${path.module}/hello.txt")
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
