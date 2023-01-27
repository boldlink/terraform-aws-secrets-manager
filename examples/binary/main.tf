resource "random_string" "random" {
  length  = 32
  special = true
}

module "binary_string" {
  source        = "./../../"
  name          = "example-binary-secret"
  description   = "a binary secret example"
  secret_policy = local.policy
  secrets = {
    secret1 = {
      secret_binary = base64encode(random_string.random.result)
    }
  }
  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform-registry"
    department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "cExample"
    LayerId            = "cExample"
  }
}
