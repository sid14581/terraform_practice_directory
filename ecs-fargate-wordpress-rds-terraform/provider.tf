terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "ecs-fargate-wordpress-rds-bucket"
    key            = "ecs-fargate-wordpress-rds/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "ecs-fargate-wordpress-rds-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}