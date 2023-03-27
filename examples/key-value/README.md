[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-secretsmanager.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# Terraform module example of a key_pair secret


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.60.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_pair_string"></a> [key\_pair\_string](#module\_key\_pair\_string) | ./../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /\_+=.@- Conflicts with name\_prefix. | `string` | `"keyvalue-secret-example"` | no |
| <a name="input_secret_description"></a> [secret\_description](#input\_secret\_description) | Description of the secret. | `string` | `"Example key-value secret"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the object. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "example",<br>  "LayerId": "Example",<br>  "LayerName": "Example",<br>  "Name": "keyvalue-secret-example",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform-registry"<br>}</pre> | no |

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
