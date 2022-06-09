module "minimum" {
  source      = "./../../"
  name        = "example-minimum-secret"
  description = "Example minimum secret"
  kms_key_id  = data.aws_kms_alias.secretsmanager.target_key_arn
  secrets = {
    single_string = {
      secret_string = "Sample String"
    }
  }
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}
