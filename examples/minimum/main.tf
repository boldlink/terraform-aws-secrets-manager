module "minimum" {
  source      = "./../../"
  name        = var.name
  description = var.secret_description
  secrets = {
    single_string = {
      secret_string = "Sample String"
    }
  }
  tags = var.tags
}
