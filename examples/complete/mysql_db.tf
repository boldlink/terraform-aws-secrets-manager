resource "aws_db_subnet_group" "mysql" {
  name       = "${local.name}-dbsubnet-group"
  subnet_ids = flatten(module.rotation_vpc.private_subnet_id)

  tags = {
    Name = local.name
  }
}

resource "random_password" "mysql_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "mysql" {
  allocated_storage                   = 20
  engine                              = "mysql"
  engine_version                      = "8.0.28"
  instance_class                      = "db.t2.micro"
  db_name                             = "exampledb"
  identifier                          = "${local.name}-instance"
  username                            = "admin"
  password                            = random_password.mysql_password.result
  skip_final_snapshot                 = true
  multi_az                            = true
  storage_encrypted                   = true
  iam_database_authentication_enabled = true
  enabled_cloudwatch_logs_exports     = ["general", "error", "slowquery"]
  auto_minor_version_upgrade          = true
  monitoring_interval                 = 30
  monitoring_role_arn                 = aws_iam_role.monitoring.arn
  vpc_security_group_ids              = [aws_security_group.mysql.id]
  db_subnet_group_name                = aws_db_subnet_group.mysql.name
}

resource "aws_iam_role" "monitoring" {
  name               = "${local.name}-enhanced-monitoring-role"
  assume_role_policy = data.aws_iam_policy_document.monitoring.json
  description        = "enhanced monitoring iam role for rds instance."
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  role       = aws_iam_role.monitoring.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
