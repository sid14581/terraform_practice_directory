terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }
  }


  backend "s3" {
    bucket         = "ecs-service-007"
    key            = "terraform/ecs-fargate-wordpress-rds/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "ecs-dynamo-007"
    encrypt        = true
  }

}

provider "aws" {
  region = var.region
}

