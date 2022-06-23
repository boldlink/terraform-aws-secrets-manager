/*resource "aws_db_subnet_group" "default" {
  name       = "example-mysql"
  subnet_ids = ["subnet-0a1af318e7780f781", "subnet-07b89216ed1d30b62", "subnet-0bbc73f8db9bf36d8",]

  tags = {
    Name = "example-mysql"
  }
}*/

resource "random_password" "mysql_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  db_name              = "randominstancemysql"
  identifier           = "randominstancemysql"
  username             = "admin"
  password             = random_password.mysql_password.result
  skip_final_snapshot  = true
  multi_az = true
  storage_encrypted    = true  
  iam_database_authentication_enabled = true
  enabled_cloudwatch_logs_exports = ["general", "error", "slowquery"]
  auto_minor_version_upgrade = true
  #monitoring_interval = 30
  #vpc_security_group_ids = [ aws_security_group.mysql.id ]
  publicly_accessible = true
  #allow_major_version_upgrade = true
  #db_subnet_group_name = aws_db_subnet_group.default.name
}

resource "aws_security_group" "mysql" {
  name        = "${local.name}-security-group"
  description = "Allow inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
               cidr_blocks      = [
                   "0.0.0.0/0",
                ]
               description      = ""
               from_port        = 0
               ipv6_cidr_blocks = ["::/0",]
               prefix_list_ids  = []
               protocol         = "-1"
               security_groups  = []
               self             = false
               to_port          = 0
          }
  egress {
               cidr_blocks      = [
                   "0.0.0.0/0",
                ]
               description      = ""
               from_port        = 0
               ipv6_cidr_blocks = ["::/0",]
               prefix_list_ids  = []
               protocol         = "-1"
               security_groups  = []
               self             = false
               to_port          = 0
          }

  tags = {
    Name = "mysql-new"
  }
}

