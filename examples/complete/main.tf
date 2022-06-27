
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
          engine   = aws_db_instance.mysql.engine
          host     = aws_db_instance.mysql.address
          username = aws_db_instance.mysql.username
          password = random_password.mysql_password.result
          dbname   = aws_db_instance.mysql.db_name
          port     = aws_db_instance.mysql.port
      })
    }
  }
  tags = {
    environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}

module "rotation_vpc" {
  source               = "git::https://github.com/boldlink/terraform-aws-vpc.git?ref=2.0.3"
  name                 = "${local.name}-vpc"
  account              = data.aws_caller_identity.current.account_id
  region               = data.aws_region.current.name
  tag_env              = local.tag_env
  cidr_block           = local.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  private_subnets      = local.rotation_subnets
  availability_zones   = local.azs
}

resource "aws_vpc_endpoint" "rotation_vpc" {
  vpc_id            = module.rotation_vpc.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids        = flatten(module.rotation_vpc.private_subnet_id)

  security_group_ids = [
    aws_security_group.mysql.id,
  ]

  private_dns_enabled = true
}

resource "aws_security_group" "mysql" {
  name        = "${local.name}-security-group"
  description = "Allow inbound traffic"
  vpc_id      = module.rotation_vpc.id

  ingress {
    cidr_blocks     = [local.cidr_block]
    description     = "mysql ingress rule"
    from_port       = 0
    prefix_list_ids = []
    protocol        = "-1"
    security_groups = [aws_security_group.lambda.id]
    self            = false
    to_port         = 0
  }
  egress {
    cidr_blocks     = [local.cidr_block]
    description     = "mysql egress rule"
    from_port       = 0
    prefix_list_ids = []
    protocol        = "-1"
    security_groups = []
    self            = false
    to_port         = 0
  }

  tags = {
    Name = local.name
  }
  lifecycle {
    create_before_destroy = true
  }
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
    description     = ""
    from_port       = 0
    prefix_list_ids = []
    protocol        = "-1"
    security_groups = []
    self            = false
    to_port         = 0
  }
  lifecycle {
    create_before_destroy = true
  }
}
