module "rds_kms" {
  source              = "boldlink/kms/aws"
  version             = "1.1.0"
  description         = "key for mysql"
  create_kms_alias    = true
  enable_key_rotation = true
  alias_name          = "alias/${local.name}-rds-key"
  tags                = local.tags
}

resource "random_password" "mysql_password" {
  length  = 16
  special = false
}

module "mysql" {
  source                              = "boldlink/rds/aws"
  version                             = "1.1.0"
  engine                              = "mysql"
  instance_class                      = "db.t3.micro"
  subnet_ids                          = flatten(module.rotation_vpc.private_subnet_id)
  name                                = "exampledb"
  username                            = "admin"
  password                            = random_password.mysql_password.result
  kms_key_id                          = module.rds_kms.arn
  port                                = 3306
  iam_database_authentication_enabled = true
  multi_az                            = true
  create_security_group               = true
  enabled_cloudwatch_logs_exports     = ["general", "error", "slowquery"]
  create_monitoring_role              = true
  monitoring_interval                 = 30
  deletion_protection                 = false
  vpc_id                              = module.rotation_vpc.id
  assume_role_policy                  = data.aws_iam_policy_document.monitoring.json
  policy_arn                          = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version                = "8.0"

  tags = merge({
    "InstanceScheduler" = true },
  local.tags)

  security_group_ingress = [
    {
      description = "inbound rds traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [local.cidr_block]
    }
  ]
  security_group_egress = [
    {
      description = "Rule to allow outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = [local.cidr_block]
    }
  ]
}
