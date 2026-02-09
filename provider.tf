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
    region = "eu-west-2"
    dynamodb_table = "nandadb"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}

