
resource "aws_secretsmanager_secret" "this" {
    description = var.description
    kms_key_id = var.kms_key_id
    name_prefix = var.name_prefix
    name = var.name
    policy = var.policy
    recovery_window_in_days = var.recovery_window_in_days
    replica {
      kms_key_id = var.kms_key_id
      region = var.region
    }
    force_overwrite_replica_secret = var.force_overwrite_replica_secret
    tags = merge(
    {
      "Environment" = var.environment
    },
    var.other_tags,
  ) 
}

resource "aws_secretsmanager_secret_rotation" "this" {
    count = var.enable_secretsmanager_secret_rotation ? 1 : 0
    secret_id = aws_secretsmanager_secret.this.id
    rotation_lambda_arn = var.rotation_lambda_arn
    dynamic "rotation_rules" {
      for_each = var.rotation_rules
      content{
        automatically_after_days = lookup (rotation_rules.value, "automatically_after_days", null)
      }
    }   
}


resource "aws_secretsmanager_secret_version" "this" {
    count = var.enable_secretsmanager_secret_version ? 1 : 0
    secret_id = aws_secretsmanager_secret.this.id
    secret_string = jsonencode(var.secret_string)
    secret_binary = var.secret_binary
    version_stages = var.version_stages  
}

resource "aws_secretsmanager_secret_policy" "name" {
    count = var.enable_secretsmanager_secret_policy ? 1 : 0
    policy = var.policy
    secret_arn = aws_secretsmanager_secret.this.arn
    block_public_policy = var.block_public_policy
}
