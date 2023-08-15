variable "name" {
  description = " Friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /_+=.@- Conflicts with name_prefix."
  type        = string
  default     = "example-complete-secret"
}

variable "secret_description" {
  description = " Description of the secret."
  type        = string
  default     = "Example complete secret with rotation"
}

variable "enable_secretsmanager_secret_rotation" {
  description = "Whether to enable secrets rotation"
  type        = bool
  default     = true
}

variable "automatically_after_days" {
  description = "Specifies the number of days between automatic scheduled rotations of the secret."
  type        = number
  default     = 7
}

### VPC Endpoint
variable "vpc_endpoint_type" {
  description = "The VPC endpoint type, Gateway, GatewayLoadBalancer, or Interface. Defaults to Gateway."
  type        = string
  default     = "Interface"
}

variable "private_dns_enabled" {
  description = "AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type Interface. Defaults to false."
  type        = bool
  default     = true
}

### Lambda
variable "filename" {
  type        = string
  description = " Path to the function's deployment package within the local filesystem. Conflicts with `image_uri`, `s3_bucket`, `s3_key`, and `s3_object_version`."
  default     = "mysql-lambda.zip"
}

variable "runtime" {
  type        = string
  description = " Identifier of the function's runtime."
  default     = "python3.9"
}

variable "function_description" {
  type        = string
  description = "Description of what your Lambda Function does."
  default     = "AWS SecretsManager secret rotation for RDS MySQL using single user."
}

variable "timeout" {
  type        = number
  description = " Amount of time your Lambda Function has to run in seconds."
  default     = 3
}

variable "reserved_concurrent_executions" {
  type        = number
  description = " Amount of reserved concurrent executions for this lambda function. A value of `0` disables lambda from being triggered and `-1` removes any concurrency limitations. Defaults to Unreserved Concurrency Limits `-1`"
  default     = 3
}

variable "mode" {
  description = "Whether to sample and trace a subset of incoming requests with AWS X-Ray. Valid values are PassThrough and Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with `sampled=1`. If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision."
  type        = string
  default     = "Active"
}

### KMS key
variable "key_description" {
  description = "The description of the key as viewed in AWS console."
  type        = string
  default     = "key for secrets stack"
}

variable "create_kms_alias" {
  description = "Whether to create KMS alias or not"
  type        = bool
  default     = true
}

### RDS Instance
variable "engine" {
  description = " The database engine to use."
  type        = string
  default     = "mysql"
}

variable "instance_class" {
  description = "The instance class for your instance(s)."
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "exampledb"
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "admin"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled"
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Boolean if specified leave availability_zone empty, default = false"
  type        = bool
  default     = true
}

variable "create_security_group" {
  description = "Whether to create a Security Group for RDS cluster."
  default     = true
  type        = bool
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = ["general", "error", "slowquery"]
}

variable "create_monitoring_role" {
  description = "Create an IAM role for enhanced monitoring"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 30
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  type        = bool
  default     = false
}

variable "major_engine_version" {
  description = " Specifies the major version of the engine that this option group should be associated with."
  type        = string
  default     = "8.0"
}

variable "length" {
  description = " The length of the string desired. The minimum value for length is 1"
  type        = number
  default     = 16
}

variable "special" {
  description = " Include special characters in the result. These are !@#$%&*()-_=+[]{}<>:?"
  type        = bool
  default     = false
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR"
  default     = "10.3.0.0/16"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the created resources"
  default = {
    Environment        = "examples"
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    InstanceScheduler  = true
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "cExample"
    LayerId            = "cExample"
  }
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Whether to enable dns hostnames"
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Whether to enable dns support for the vpc"
  default     = true
}

variable "enable_internal_subnets" {
  type        = bool
  description = "Whether to enable internal subnets"
  default     = true
}
