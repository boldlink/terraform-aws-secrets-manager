[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-secretsmanager.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# Terraform  module example of complete and most common configuration


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.45.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.57.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_kms"></a> [lambda\_kms](#module\_lambda\_kms) | boldlink/kms/aws | 1.1.0 |
| <a name="module_mysql"></a> [mysql](#module\_mysql) | boldlink/rds/aws | 1.1.2 |
| <a name="module_rds_kms"></a> [rds\_kms](#module\_rds\_kms) | boldlink/kms/aws | 1.1.0 |
| <a name="module_secret_rotation"></a> [secret\_rotation](#module\_secret\_rotation) | ./../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | boldlink/vpc/aws | 2.0.3 |

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
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the object. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "example",<br>  "LayerId": "Example",<br>  "LayerName": "Example",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform-registry"<br>}</pre> | no |

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
