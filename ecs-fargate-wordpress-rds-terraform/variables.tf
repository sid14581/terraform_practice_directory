# provider.tf 

variable "region" {
  description = "The AWS region to deploy the resources in"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "The name of the S3 bucket for storing WordPress files"
  type        = string
  default     = "ecs-fargate-wordpress-rds-bucket"
}

variable "key" {
  description = "The key for the S3 object"
  type        = string
  default     = "ecs-fargate-wordpress-rds/terraform.tfstate"
}

variable "dynamodb_table" {
  description = "The name of the DynamoDB table for state locking"
  type        = string
  default     = "ecs-fargate-wordpress-rds-lock"
}

# vpc.tf

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr_block_subnet_a" {
  description = "The CIDR block for the first subnet"
  type        = string
  default     = "10.0.0.0/24"
}