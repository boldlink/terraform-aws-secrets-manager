resource "random_string" "random" {
  length  = 32
  special = true
}

module "binary_string" {
  source        = "./../../"
  name          = "example-binary-secret2"
  description   = "a binary secret example"
  kms_key_id    = data.aws_kms_alias.secretsmanager.target_key_arn
  secret_policy = local.policy
  secrets = {
    secret1 = {
      secret_binary = base64encode(random_string.random.result)
    }
  }
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}
