resource "aws_vpc" "sid_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "sid_vpc"
  }
}