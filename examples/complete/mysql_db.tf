resource "random_password" "mysql_password" {
  length  = var.length
  special = var.special
}


module "mysql" {
  source                              = "boldlink/rds/aws"
  version                             = "1.1.2"
  engine                              = var.engine
  instance_class                      = var.instance_class
  subnet_ids                          = flatten(module.vpc.isolated_subnet_id)
  name                                = var.db_name
  username                            = var.username
  password                            = random_password.mysql_password.result
  kms_key_id                          = module.kms.arn
  port                                = var.port
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  multi_az                            = var.multi_az
  create_security_group               = var.create_security_group
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  create_monitoring_role              = var.create_monitoring_role
  monitoring_interval                 = var.monitoring_interval
  deletion_protection                 = var.deletion_protection
  vpc_id                              = module.vpc.id
  assume_role_policy                  = data.aws_iam_policy_document.monitoring.json
  policy_arn                          = "arn:${local.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  major_engine_version                = var.major_engine_version

  tags = merge({
    InstanceScheduler = true },
    { Name = var.name },
  var.tags)

  security_group_ingress = [
    {
      description = "inbound rds traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = local.private_subnets
    }
  ]
  security_group_egress = [
    {
      description = "Rule to allow outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = local.private_subnets
    }
  ]
}
