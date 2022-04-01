## Description
This Terraform module manages AWS Secrets Manager secret metadata.

Examples available [here](https://github.com/boldlink/terraform-aws-secrets-manager/tree/main/examples)

## Documentation

[AWS Secrets Manager ](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)

[Terraform Secrets Manager Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret)
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.8.0 |

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
| <a name="input_enable_secretsmanager_secret_policy"></a> [enable\_secretsmanager\_secret\_policy](#input\_enable\_secretsmanager\_secret\_policy) | Whether to enable secret policy | `bool` | `false` | no |
| <a name="input_enable_secretsmanager_secret_rotation"></a> [enable\_secretsmanager\_secret\_rotation](#input\_enable\_secretsmanager\_secret\_rotation) | Whether to enable secrets rotation | `bool` | `false` | no |
| <a name="input_enable_secretsmanager_secret_version"></a> [enable\_secretsmanager\_secret\_version](#input\_enable\_secretsmanager\_secret\_version) | Whether to enable secret version | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment this resource is being deployed to | `string` | `null` | no |
| <a name="input_force_overwrite_replica_secret"></a> [force\_overwrite\_replica\_secret](#input\_force\_overwrite\_replica\_secret) | (Optional) Accepts boolean value to specify whether to overwrite a secret with the same name in the destination Region. | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | (Optional) ARN or Id of the AWS KMS key to be used to encrypt the secret values in the versions stored in this secret. If you don't specify this value, then Secrets Manager defaults to using the AWS account's default KMS key (the one named aws/secretsmanager).If the default KMS key with that name doesn't yet exist, then AWS Secrets Manager creates it for you automatically the first time. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /\_+=.@- Conflicts with name\_prefix. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Creates a unique name beginning with the specified prefix. Conflicts with name. | `string` | `null` | no |
| <a name="input_other_tags"></a> [other\_tags](#input\_other\_tags) | For adding an additional values for tags | `map(string)` | `{}` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | (Required) Valid JSON document representing a resource policy. | `string` | `null` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | (Optional) Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30. | `number` | `30` | no |
| <a name="input_rotation_lambda_arn"></a> [rotation\_lambda\_arn](#input\_rotation\_lambda\_arn) | (Required) Specifies the ARN of the Lambda function that can rotate the secret. | `string` | `""` | no |
| <a name="input_secret_binary"></a> [secret\_binary](#input\_secret\_binary) | (Optional) Specifies binary data that you want to encrypt and store in this version of the secret. This is required if secret\_string is not set. Needs to be encoded to base64. | `string` | `null` | no |
| <a name="input_secret_string"></a> [secret\_string](#input\_secret\_string) | (Optional) Specifies text data that you want to encrypt and store in this version of the secret. This is required if secret\_binary is not set. | `string` | `null` | no |
| <a name="input_version_stages"></a> [version\_stages](#input\_version\_stages) | (Optional) Specifies a list of staging labels that are attached to this version of the secret. A staging label must be unique to a single version of the secret. If you specify a staging label that's already associated with a different version of the same secret then that staging label is automatically removed from the other version and attached to this version. If you do not specify a value, then AWS Secrets Manager automatically moves the staging label AWSCURRENT to this new version on creation. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the secret. |
| <a name="output_id"></a> [id](#output\_id) | ARN of the secret. |
| <a name="output_replica"></a> [replica](#output\_replica) | Date that you last accessed the secret in the Region. |
| <a name="output_rotation_enabled"></a> [rotation\_enabled](#output\_rotation\_enabled) | Whether automatic rotation is enabled for this secret. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | Map of tags assigned to the resource, including those inherited from the provider default\_tags |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
