terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.45.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.2.0"
    }
  }
  required_version = ">= 0.14.11"
}
