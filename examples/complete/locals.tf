locals {
  name     = "example-complete-secret"
  filename = "secrets_manager_rotation.zip"
  policy   = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "EnablePermissions",
          "Effect": "Allow",
          "Principal": {
            "AWS": "${data.aws_caller_identity.current.arn}"
          },
          "Action": "secretsmanager:GetSecretValue",
          "Resource": "*"
        }
      ]
    }
    POLICY
}
