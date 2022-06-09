
data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_kms_alias" "secretsmanager" {
  name = "alias/aws/secretsmanager"
}
