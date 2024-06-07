
resource "aws_eip" "sid_eip" {
    id = aws_vpc.sid_vpc.id
}

resource "aws_nat_gateway" "sid_ngw" {
    depends_on = [ aws_eip.sid_eip ]
    allocation_id = aws_eip.sid_eip.id
    subnet_id = aws_subnet.sid_private_subnet.id
    tags = {
      Name = "sid ngw"
    }
}