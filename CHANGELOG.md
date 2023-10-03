# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [Unreleased]
- feat: Add scan for python code and dependencies.
- feat: Add keypair pub/priv example
- fix: use the kms key created in complete example to encrypt cloudwatch logs
- fix: attach only one security group to the lambda function created

## [1.0.8] - 2023-09-29
- replaced lambda stand-alone resources with Boldlink's lambda module in complete example
- set block_public_policy to true in complete example

## [1.0.7] - 2023-08-14
### Description
- fix: update vpc module version. The module was previously using a version which has deprecated arguments

## [1.0.6] - 2023-03-02
### Description
- fix:  CKV_AWS_290: "Ensure IAM policies does not allow write access without constraints"
- fix: removed unnecessary zipped files committed to github
- moved example tags to variables.tf file

## [1.0.5] - 2023-01-25
### Description
- fix: Remove deprecated attribute `rotation_enabled`.
- feat: Add latest workflow files.

## [1.0.4] - 2022-08-04
### Description
- feature: Use a CMK in the complete example
- Use rds module in the complete example


## [1.0.3] - 2022-06-24
### Description
- fix: secrets manager rotation code
- added: mysql instance, vpc, endpoint, security groups and policies to test rotation
- fix: lambda vpc checkov flag

## [1.0.2] - 2022-06-06
### Description
- Standard files added
- Complete and minimum examples
- Checkov security check fixes
- tags variable edit

## [1.0.1] - 2022-04-22
### Description
- Added: binary, single-string, rotation and key_pair examples

## [1.0.0] - 2022-04-01
### Description
- Feature: Secrets manager
- Feature: Secrets rotation
- Feature: Secrets version
- feature: Secrets policy

[Unreleased]: https://github.com/boldlink/terraform-aws-secretsmanager/compare/1.0.8...HEAD

[1.0.8]: https://github.com/boldlink/terraform-aws-secretsmanager/releases/tag/1.0.8
[1.0.7]: https://github.com/boldlink/terraform-aws-secretsmanager/releases/tag/1.0.7
[1.0.6]: https://github.com/boldlink/terraform-aws-secretsmanager/releases/tag/1.0.6
[1.0.5]: https://github.com/boldlink/terraform-aws-secretsmanager/releases/tag/1.0.5
[1.0.4]: https://github.com/boldlink/terraform-aws-secretsmanager/releases/tag/1.0.4
[1.0.3]: https://github.com/boldlink/terraform-aws-secretsmanager/releases/tag/1.0.3
[1.0.2]: https://github.com/boldlink/terraform-aws-secretsmanager/releases/tag/1.0.2
[1.0.1]: https://github.com/boldlink/terraform-aws-secretsmanager/releases/tag/v1.0.1
[1.0.0]: https://github.com/boldlink/terraform-aws-secretsmanager/releases/tag/v1.0.0
