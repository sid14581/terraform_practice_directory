resource "aws_subnet" "provision_sub1" {
  vpc_id                  = aws_vpc.provision_vpc.id
  cidr_block              = var.cidr_sub1
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = true
}