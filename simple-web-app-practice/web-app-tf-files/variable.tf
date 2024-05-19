# S3
variable "bucket" {
  default = "damdam-dingdong"
}
variable "sse_algorithm" {
  default = "AES256"
}

# VPC
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  default = "myDemoVPC"
}

# IGW
variable "igw_name" {
  default = "myDemoIGW"
}

# cider_block_0
variable "cidr_block_0" {
}

# SG
variable "description_http" {
  default = "HTTP from VPC"
}
variable "description_ssh" {
  default = "SSH from VPC"
}

variable "sg_name" {
  default = "web-sg"
}
variable "sg_tag_name" {
  default = "myDemoSG"
}

# INSTANCES
variable "ami" {
}
variable "instance_type" {
}
variable "instance_tag_name1" {
  default = "instances_1"
}
variable "instance_tag_name2" {
  default = "instances_2"
}

# LOAD BALANCERS
variable "load_balancer_name" {
  default = "AppLB"
}
variable "load_balancer_tag_name" {
  default = "MyDemoLB"
}
variable "load_balancer_type" {
  default = "application"
}

# TARGET GROUPS
variable "target_group_name" {
  default = "MyDemoTG"
}
variable "target_group_heathcheck_port" {
  default = "traffic-port"
}


# RDS DATABASE
variable "allocated_storage" {

}
variable "db_name" {

}
variable "engine" {

}
variable "engine_version" {

}
variable "instance_class" {

}
variable "username" {

}
variable "password" {

}
variable "parameter_group_name" {

}