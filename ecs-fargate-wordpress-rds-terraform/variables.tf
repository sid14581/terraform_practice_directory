variable "region" {
  description = "The AWS region to deploy the resources in"
  type        = string
  default     = "us-east-2"
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