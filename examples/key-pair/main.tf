module "key_pair_string" {
  source        = "./../../"
  name          = "example-keypair-secret"
  description   = "this is a key_pair secret example "
  secret_policy = local.policy
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
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}
