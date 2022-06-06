module "key_pair_string" {
  source        = "./../../"
  name          = "example-keypair-secret"
  description   = "this is a key_pair secret example "
  secret_policy = local.policy
  kms_key_id    = data.aws_kms_alias.secretsmanager.target_key_arn
  secrets = {
    key_pair1 = {
      secret_string = jsonencode(
        {
          username = "test"
          password = "Random Secret"
        }
      )
    }
  }

}
