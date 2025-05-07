variable "region" {
  description = "The AWS region to deploy the resources in"
  type        = string
  default     = "us-east-2"
}


# VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "ecs-fargate-wordpress-rds-vpc"
}

# INTERNET GATEWAY
variable "igw_name" {
  description = "The name of the Internet Gateway"
  type        = string
  default     = "ecs-fargate-wordpress-rds-igw"
}

# SUBNETS
variable "subnet_a_name" {
  description = "The name of the first subnet"
  type        = string
  default     = "ecs-fargate-wordpress-rds-subnet-a"
}
variable "cidr_block_subnet_a" {
  description = "The CIDR block for the first subnet"
  type        = string
  default     = "10.0.0.0/24"
}


variable "subnet_b_name" {
  description = "The name of the second subnet"
  type        = string
  default     = "ecs-fargate-wordpress-rds-subnet-b"
}
variable "cidr_block_subnet_b" {
  description = "The CIDR block for the second subnet"
  type        = string
  default     = "10.0.1.0/24"
}


variable "subnet_c_name" {
  description = "The name of the third subnet"
  type        = string
  default     = "ecs-fargate-wordpress-rds-subnet-c"
}
variable "cidr_block_subnet_c" {
  description = "The CIDR block for the third subnet"
  type        = string
  default     = "10.0.2.0/24"
}

# ROUTE TABLES

variable "route_table_name" {
  description = "The name of the route table"
  type        = string
  default     = "ecs-fargate-wordpress-rds-route-table"
}

# SECURITY GROUPS

variable "ecs_security_group_alb_name" {
  description = "The name of the ECS security group"
  type        = string
  default     = "ecs-fargate-wordpress-alb-sg"
}

variable "ecs_security_group_rds_name" {
  description = "The name of the ECS security group"
  type        = string
  default     = "ecs-fargate-wordpress-rds-sg"
}