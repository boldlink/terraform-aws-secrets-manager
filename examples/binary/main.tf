
module "binary_string" {
  source        = "./../../"
  name          = "example-binary-secret"
  description   = "a binary secret example"
  kms_key_id    = data.aws_kms_alias.secretsmanager.target_key_arn
  secret_policy = local.policy
  secrets = {
    secret1 = {
      secret_binary = base64encode(file("${path.module}/${local.filename}"))
    }
  }
}
