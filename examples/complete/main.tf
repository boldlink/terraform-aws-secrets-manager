
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

module "rotation_vpc" {
  source               = "git::https://github.com/boldlink/terraform-aws-vpc.git?ref=2.0.3"
  name                 = "${local.name}-vpc"
  account              = local.account_id
  region               = local.region
  tag_env              = local.tag_env
  cidr_block           = local.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  private_subnets      = local.rotation_subnets
  availability_zones   = local.azs
  tags                 = local.tags
}

resource "aws_vpc_endpoint" "rotation_vpc" {
  vpc_id            = module.rotation_vpc.id
  service_name      = "com.amazonaws.${local.region}.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids        = flatten(module.rotation_vpc.private_subnet_id)


  security_group_ids = module.mysql.sg_id


  private_dns_enabled = true
  tags                = local.tags
}

resource "aws_security_group" "lambda" {
  name        = "${local.name}-lambda-security-group"
  description = "Allow inbound traffic"
  vpc_id      = module.rotation_vpc.id

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
