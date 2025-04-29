provider "aws" {
  region = "us-east-2"
}

variable "ami" {
  description = "value"
  type        = map(string)

  default = {
    "dev"   = "ami-04f167a56786e4b09"
    "prod"  = "ami-0c3b809fcf2445b6a"
    "stage" = "ami-0cf45b01462e24832"
  }
}

variable "instance_type" {
  description = "value"
}

module "ec2_instance" {
  source        = "./module/ec2_instance"
  ami           = lookup(var.ami, terraform.workspace, "ami-04f167a56786e4b09")
  instance_type = var.instance_type
}
