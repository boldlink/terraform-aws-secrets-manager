[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-secretsmanager.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-secretsmanager/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-secretsmanager/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS Secrets Manager Terraform module

## Description
This Terraform module manages AWS Secrets Manager secret metadata.

## Why choose this module
- Ensures adherence to AWS security standards through the integration of checkov for code compliance scanning.
- Easy to set up and utilize with help of clear instructions and examples.
- Removes the complexity of using multiple stand-alone resources.

Examples available [here](./examples)

## Usage
**NOTE**: These examples use the latest version of this module

```console
module "minimum" {
  source      = "boldlink/secretsmanager/aws"
  name        = "example-minimum-secret"
  description = "Example minimum secret"
  kms_key_id  = data.aws_kms_alias.secretsmanager.target_key_arn
  secrets = {
    single_string = {
      secret_string = "Sample String"
    }
  }
  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform-registry"
  }
}

```

## Documentation

[AWS Secrets Manager ](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)

[Terraform Secrets Manager Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret)
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_secretsmanager_secret_rotation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automatically_after_days"></a> [automatically\_after\_days](#input\_automatically\_after\_days) | (Required) Specifies the number of days between automatic scheduled rotations of the secret. | `number` | `30` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | (Optional) Makes an optional API call to Zelkova to validate the Resource Policy to prevent broad access to your secret. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) Description of the secret. | `string` | `null` | no |
| <a name="input_enable_secretsmanager_secret_rotation"></a> [enable\_secretsmanager\_secret\_rotation](#input\_enable\_secretsmanager\_secret\_rotation) | Whether to enable secrets rotation | `bool` | `false` | no |
| <a name="input_enable_secretsmanager_secret_version"></a> [enable\_secretsmanager\_secret\_version](#input\_enable\_secretsmanager\_secret\_version) | Whether to enable secret version | `bool` | `true` | no |
| <a name="input_force_overwrite_replica_secret"></a> [force\_overwrite\_replica\_secret](#input\_force\_overwrite\_replica\_secret) | (Optional) Accepts boolean value to specify whether to overwrite a secret with the same name in the destination Region. | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | (Optional) ARN or Id of the AWS KMS key to be used to encrypt the secret values in the versions stored in this secret. If you don't specify this value, then Secrets Manager defaults to using the AWS account's default KMS key (the one named aws/secretsmanager).If the default KMS key with that name doesn't yet exist, then AWS Secrets Manager creates it for you automatically the first time. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /\_+=.@- Conflicts with name\_prefix. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Creates a unique name beginning with the specified prefix. Conflicts with name. | `string` | `null` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | (Optional) Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30. | `number` | `30` | no |
| <a name="input_rotation_lambda_arn"></a> [rotation\_lambda\_arn](#input\_rotation\_lambda\_arn) | (Required) Specifies the ARN of the Lambda function that can rotate the secret. | `string` | `""` | no |
| <a name="input_secret_policy"></a> [secret\_policy](#input\_secret\_policy) | (Required) Valid JSON document representing a resource policy. | `string` | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Map of secrets to store. | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the object. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the secret. |
| <a name="output_id"></a> [id](#output\_id) | ARN of the secret. |
| <a name="output_replica"></a> [replica](#output\_replica) | Date that you last accessed the secret in the Region. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | Map of tags assigned to the resource, including those inherited from the provider default\_tags |
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

### Supporting resources:

The example stacks are used by BOLDLink developers to validate the modules by building an actual stack on AWS.

Some of the modules have dependencies on other modules (ex. Ec2 instance depends on the VPC module) so we create them
first and use data sources on the examples to use the stacks.

Any supporting resources will be available on the `tests/supportingResources` and the lifecycle is managed by the `Makefile` targets.

Resources on the `tests/supportingResources` folder are not intended for demo or actual implementation purposes, and can be used for reference.

### Makefile
The makefile contain in this repo is optimized for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done separately so you can test your module build/modify/destroy independently.
```console
make cleansupporting
```
* !!!DANGER!!! Clean the state files from examples and test/supportingResources - use with CAUTION!!!
```console
make cleanstatefiles
```


#### BOLDLink-SIG 2023
