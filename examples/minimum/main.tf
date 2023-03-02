module "minimum" {
  source      = "./../../"
  name        = "example-minimum-secret"
  description = "Example minimum secret"
  secrets = {
    single_string = {
      secret_string = "Sample String"
    }
  }
  tags = var.tags
}
