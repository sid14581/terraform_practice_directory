variable "ami" {
  description = "This is AMI for the instance"
}

variable "instance_type" {
  description = " damdam isntance type"
}

resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.instance_type
}