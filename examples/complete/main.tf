
module "secret_rotation" {
  source                                = "./../../"
  name                                  = var.name
  description                           = var.secret_description
  enable_secretsmanager_secret_rotation = var.enable_secretsmanager_secret_rotation
  secret_policy                         = local.policy
  automatically_after_days              = var.automatically_after_days
  rotation_lambda_arn                   = module.lambda.arn
  block_public_policy                   = var.block_public_policy
  secrets = {
    secret1 = {
      secret_string = jsonencode(
        {
          engine   = module.mysql.engine
          host     = module.mysql.address
          username = module.mysql.username
          password = random_password.mysql_password.result
          dbname   = module.mysql.db_name
          port     = module.mysql.port
      })
    }
  }
  tags = merge(
    { Name = var.name },
  var.tags)
}

module "secretsmanager_vpc" {
  source                  = "boldlink/vpc/aws"
  version                 = "3.0.4"
  name                    = var.name
  cidr_block              = var.cidr_block
  enable_dns_support      = var.enable_dns_support
  enable_dns_hostnames    = var.enable_dns_hostnames
  enable_internal_subnets = var.enable_internal_subnets
  tags                    = var.tags

  internal_subnets = {
    apps = {
      cidrs = local.internal_subnets
    }
  }
}

resource "aws_vpc_endpoint" "vpc" {
  vpc_id              = module.secretsmanager_vpc.vpc_id
  service_name        = "com.amazonaws.${local.region}.secretsmanager"
  vpc_endpoint_type   = var.vpc_endpoint_type
  subnet_ids          = flatten(local.internal_subnet_ids)
  security_group_ids  = module.mysql.sg_id
  private_dns_enabled = var.private_dns_enabled
  tags = merge(
    { Name = var.name },
  var.tags)
}

resource "aws_security_group" "lambda" {
  name        = "${var.name}-lambda-security-group"
  description = "Allow inbound traffic"
  vpc_id      = module.secretsmanager_vpc.vpc_id

  ingress {
    cidr_blocks     = [var.cidr_block]
    description     = "${var.name} lambda function ingress rule"
    from_port       = 0
    prefix_list_ids = []
    protocol        = "-1"
    security_groups = []
    self            = false
    to_port         = 0
  }
  egress {
    cidr_blocks     = [var.cidr_block]
    description     = "${var.name} lambda function egress rule"
    from_port       = 0
    prefix_list_ids = []
    protocol        = "-1"
    security_groups = []
    self            = false
    to_port         = 0
  }
  tags = merge(
    { Name = var.name },
  var.tags)
  lifecycle {
    create_before_destroy = true
  }
}

module "kms" {
  source           = "boldlink/kms/aws"
  version          = "1.1.0"
  description      = var.key_description
  create_kms_alias = var.create_kms_alias
  alias_name       = "alias/${var.name}-lambda-key"
  tags             = var.tags
}
