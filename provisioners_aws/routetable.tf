resource "aws_route_table" "provision_rt" {
  vpc_id = aws_vpc.provision_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.provision_igw.id
  }
}

resource "aws_route_table_association" "provision_association_rt1" {
  subnet_id      = aws_subnet.provision_sub1.id
  route_table_id = aws_route_table.provision_rt.id
}