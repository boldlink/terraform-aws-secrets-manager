module "key_pair_string" {
  source        = "./../../"
  name          = "keyvalue-secret-example"
  description   = "this is a key-value secret example"
  secret_policy = local.policy
  secrets = {
    key_value1 = {
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
