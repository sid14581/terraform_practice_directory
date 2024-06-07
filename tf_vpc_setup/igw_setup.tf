resource "aws_internet_gateway" "sid_igw" {
  vpc_id = aws_vpc.sid_vpc.id
  tags = {
    Name = "sid_igw"
  }
}