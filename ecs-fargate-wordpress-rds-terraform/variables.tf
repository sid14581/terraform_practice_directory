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

# RDS

variable "db_instance_type" {
  description = "RDS instance type"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "wordpressdb"
}

variable "db_user" {
  description = "The username for the database"
  type        = string
  default     = "wordpressuser"
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  default     = "wordpresspassword"
}

variable "db_port" {
  description = "The port for the database"
  type        = string
  default     = "3306"
}

variable "db_engine" {
  description = "The database engine"
  type        = string
  default     = "mariadb"
}

variable "db_engine_version" {
  description = "The database engine version"
  type        = string
  default     = "10.11"
}

variable "storage_type" {
  description = "The storage type for the database"
  type        = string
  default     = "gp2"
}

variable "allocated_storage" {
  description = "The allocated storage for the database"
  type        = number
  default     = 20
}

variable "identifier" {
  description = "The identifier for the database instance"
  type        = string
  default     = "ecs-fargate-wordpress-rds-db"
}

variable "multi_az" {
  description = "Whether to create a Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
  default     = "default.mariadb10.11"
}

# ECS CLUSTER
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "ecs-fargate-wordpress-cluster"
}

variable "ecs_task_family_name" {
  description = "The name of the ECS task family"
  type        = string
  default     = "wp-ecs-task-tf"
}

variable "ecs_task_cpu" {
  description = "The CPU units for the ECS task"
  type        = string
  default     = "512"
}

variable "ecs_task_memory" {
  description = "The memory for the ECS task"
  type        = string
  default     = "1024"
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "ecs-fargate-wordpress-service"
}

variable "desired_count" {
  description = "The desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "container_name" {
  description = "The name of the container"
  type        = string
  default     = "wordpress"
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
  default     = 80
}


# ALB
variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default     = "ecs-fargate-wordpress-alb"
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
  default     = "ecs-fargate-wp-target-group"
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
  default     = 80
}
