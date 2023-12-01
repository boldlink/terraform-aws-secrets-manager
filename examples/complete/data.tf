data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "mysql-lambda/src"
  output_path = var.filename
}

data "archive_file" "pymysql" {
  depends_on  = [null_resource.pymysql]
  type        = "zip"
  source_dir  = "./mysql-lambda/libraries"
  output_path = "pymysql.zip"
}

data "aws_iam_policy_document" "monitoring" {
  statement {
    sid = "GrantAssumeRolePermission"
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

data "aws_subnets" "internal" {
  filter {
    name   = "tag:Name"
    values = ["${var.name}*.int.*"]
  }
  depends_on = [module.secretsmanager_vpc]
}
