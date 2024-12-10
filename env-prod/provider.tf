provider "aws" {
  # Region is specified in the `terraform.tfvars`
  region  = "ap-south-1"
  profile = "default"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
  }
  ##
  ## specify your S3 Bucket Information below for backend
  ##
  backend "s3" {
    # account_based_change
    bucket = "rnterra"
    key    = "terraform.tfstate"

    # S3 backend's region
    region  = "ap-south-1"
    profile = "default"
  }
}
