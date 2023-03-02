
module "secret_rotation" {
  source                                = "./../../"
  name                                  = local.name
  description                           = "Example complete secret with rotation"
  enable_secretsmanager_secret_rotation = true
  secret_policy                         = local.policy
  automatically_after_days              = 7
  rotation_lambda_arn                   = aws_lambda_function.mysql.arn
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
  tags = local.tags
}

module "vpc" {
  source               = "boldlink/vpc/aws"
  version              = "2.0.3"
  name                 = "${local.name}-vpc"
  account              = local.account_id
  region               = local.region
  cidr_block           = local.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  private_subnets      = local.private_subnets
  isolated_subnets     = local.isolated_subnets
  availability_zones   = local.azs
  other_tags           = local.tags
}

resource "aws_vpc_endpoint" "vpc" {
  vpc_id            = module.vpc.id
  service_name      = "com.amazonaws.${local.region}.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids        = flatten(module.vpc.private_subnet_id)
  security_group_ids = module.mysql.sg_id
  private_dns_enabled = true
  tags                = local.tags
}

resource "aws_security_group" "lambda" {
  name        = "${local.name}-lambda-security-group"
  description = "Allow inbound traffic"
  vpc_id      = module.vpc.id

  ingress {
    cidr_blocks     = [local.cidr_block]
    description     = "lambda function ingress rule"
    from_port       = 0
    prefix_list_ids = []
    protocol        = "-1"
    security_groups = []
    self            = false
    to_port         = 0
  }
  egress {
    cidr_blocks     = [local.cidr_block]
    description     = "lambda function egress rule"
    from_port       = 0
    prefix_list_ids = []
    protocol        = "-1"
    security_groups = []
    self            = false
    to_port         = 0
  }
  tags = local.tags
  lifecycle {
    create_before_destroy = true
  }
}
