
data "aws_kms_alias" "secretsmanager" {
  name = "alias/aws/secretsmanager"
}
