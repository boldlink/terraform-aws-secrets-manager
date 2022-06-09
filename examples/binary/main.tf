resource "random_string" "random" {
  length  = 32
  special = true
}

module "binary_string" {
  source        = "./../../"
  name          = "example-binary-secret"
  description   = "a binary secret example"
  kms_key_id    = data.aws_kms_alias.secretsmanager.target_key_arn
  secret_policy = local.policy
  secrets = {
    secret1 = {
      secret_binary = random_string.random.result
    }
  }
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}
