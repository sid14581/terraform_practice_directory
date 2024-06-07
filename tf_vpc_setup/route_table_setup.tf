resource "aws_route_table" "sid_public_route_table" {
  vpc_id = aws_vpc.sid_vpc.id
  tags = {
    Name = "sid_public_route_table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sid_igw.id
  }
}

resource "aws_route_table" "sid_private_route_table" {
  vpc_id = aws_vpc.sid_vpc.id
  tags = {
    Name = "sid_private_route_table"
  }
  depends_on = [ aws.aws_nat_gateway]
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sid_ngw.id
  }
}