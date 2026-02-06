terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0" #Aws provider function not terraform
    }
  }

  backend "s3" {
    bucket = "nanda3sa"
    key    = "eksctl"
    region = "us-east-1"
    dynamodb_table = "nandadb"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

