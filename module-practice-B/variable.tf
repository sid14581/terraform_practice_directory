variable "web-instance-type" {
  type        = string
  description = "Instance Type of EC2"
  default     = "t2.micro"
}

variable "ami" {
  type        = string
  description = "EC2 Machine Ami ID"
  default     = "ami-0bb84b8ffd87024d8"
}

variable "aws_key_pair_keyName" {
  default = "aws_key"
}


