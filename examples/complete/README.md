[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-secretsmanager.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# Terraform  module example of complete and most common configuration


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.60.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.4.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.19.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | boldlink/kms/aws | 1.1.0 |
| <a name="module_mysql"></a> [mysql](#module\_mysql) | boldlink/rds/aws | 1.1.2 |
| <a name="module_secret_rotation"></a> [secret\_rotation](#module\_secret\_rotation) | ./../../ | n/a |
| <a name="module_secretsmanager_vpc"></a> [secretsmanager\_vpc](#module\_secretsmanager\_vpc) | boldlink/vpc/aws | 3.0.4 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.mysql_lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.mysql_lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.mysql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_security_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_endpoint.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [random_password.mysql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [archive_file.lambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnets.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automatically_after_days"></a> [automatically\_after\_days](#input\_automatically\_after\_days) | Specifies the number of days between automatic scheduled rotations of the secret. | `number` | `7` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | (Optional) Makes an optional API call to Zelkova to validate the Resource Policy to prevent broad access to your secret. | `bool` | `true` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | VPC CIDR | `string` | `"10.3.0.0/16"` | no |
| <a name="input_create_kms_alias"></a> [create\_kms\_alias](#input\_create\_kms\_alias) | Whether to create KMS alias or not | `bool` | `true` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Create an IAM role for enhanced monitoring | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a Security Group for RDS cluster. | `bool` | `true` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The DB name to create. If omitted, no database is created initially | `string` | `"exampledb"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false. | `bool` | `false` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Whether to enable dns hostnames | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Whether to enable dns support for the vpc | `bool` | `true` | no |
| <a name="input_enable_internal_subnets"></a> [enable\_internal\_subnets](#input\_enable\_internal\_subnets) | Whether to enable internal subnets | `bool` | `true` | no |
| <a name="input_enable_secretsmanager_secret_rotation"></a> [enable\_secretsmanager\_secret\_rotation](#input\_enable\_secretsmanager\_secret\_rotation) | Whether to enable secrets rotation | `bool` | `true` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list(string)` | <pre>[<br>  "general",<br>  "error",<br>  "slowquery"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to use. | `string` | `"mysql"` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Path to the function's deployment package within the local filesystem. Conflicts with `image_uri`, `s3_bucket`, `s3_key`, and `s3_object_version`. | `string` | `"mysql-lambda.zip"` | no |
| <a name="input_function_description"></a> [function\_description](#input\_function\_description) | Description of what your Lambda Function does. | `string` | `"AWS SecretsManager secret rotation for RDS MySQL using single user."` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled | `bool` | `true` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance class for your instance(s). | `string` | `"db.t3.micro"` | no |
| <a name="input_key_description"></a> [key\_description](#input\_key\_description) | The description of the key as viewed in AWS console. | `string` | `"key for secrets stack"` | no |
| <a name="input_length"></a> [length](#input\_length) | The length of the string desired. The minimum value for length is 1 | `number` | `16` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | Specifies the major version of the engine that this option group should be associated with. | `string` | `"8.0"` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | Whether to sample and trace a subset of incoming requests with AWS X-Ray. Valid values are PassThrough and Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with `sampled=1`. If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision. | `string` | `"Active"` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `30` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Boolean if specified leave availability\_zone empty, default = false | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /\_+=.@- Conflicts with name\_prefix. | `string` | `"example-complete-secret"` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `string` | `"3306"` | no |
| <a name="input_private_dns_enabled"></a> [private\_dns\_enabled](#input\_private\_dns\_enabled) | AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type Interface. Defaults to false. | `bool` | `true` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | Amount of reserved concurrent executions for this lambda function. A value of `0` disables lambda from being triggered and `-1` removes any concurrency limitations. Defaults to Unreserved Concurrency Limits `-1` | `number` | `3` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Identifier of the function's runtime. | `string` | `"python3.9"` | no |
| <a name="input_secret_description"></a> [secret\_description](#input\_secret\_description) | Description of the secret. | `string` | `"Example complete secret with rotation"` | no |
| <a name="input_special"></a> [special](#input\_special) | Include special characters in the result. These are !@#$%&*()-\_=+[]{}<>:? | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the created resources | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "examples",<br>  "InstanceScheduler": true,<br>  "LayerId": "cExample",<br>  "LayerName": "cExample",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform-registry"<br>}</pre> | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Amount of time your Lambda Function has to run in seconds. | `number` | `3` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user | `string` | `"admin"` | no |
| <a name="input_vpc_endpoint_type"></a> [vpc\_endpoint\_type](#input\_vpc\_endpoint\_type) | The VPC endpoint type, Gateway, GatewayLoadBalancer, or Interface. Defaults to Gateway. | `string` | `"Interface"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

#### BOLDLink-SIG 2023
