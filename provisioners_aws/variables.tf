variable "region" {
  type    = string
  default = "us-east-2"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cidr_sub1" {
  type    = string
  default = "10.0.0.0/24"
}

variable "availability_zone1" {
  type    = string
  default = "us-east-2a"
}

variable "availability_zone2" {
  type    = string
  default = "us-east-2b"
}

variable "availability_zone3" {
  type    = string
  default = "us-east-2c"
}

variable "key_name" {
  type    = string
  default = "terraform_key_name"
}

variable "sgp_name" {
  type    = string
  default = "web_sgp"
}