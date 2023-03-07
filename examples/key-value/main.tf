module "key_pair_string" {
  source        = "./../../"
  name          = var.name
  description   = var.secret_description
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
  tags = var.tags
}
