variable "web-instance-type" {
  type        = string
  description = "Instance Type of EC2"
  default     = "t2.micro"
}

variable "ami" {
  type        = string
  description = "EC2 Machine Ami ID"
  default     = "ami-0c4596ce1e7ae3e68"
}

variable "aws_key_pair_keyName" {
  default = "aws_key"
}


