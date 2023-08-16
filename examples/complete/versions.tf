terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.60.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.2.0"
    }
    archive = {
      version = ">= 2.0.0"
      source  = "hashicorp/archive"
    }
  }
  required_version = ">= 0.14.11"
}
