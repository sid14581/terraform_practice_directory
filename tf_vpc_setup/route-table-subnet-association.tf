resource "aws_route_table_association" "public_subnet_association" {
  depends_on = [ aws_route_table.sid_public_route_table, aws_subnet.sid_public_subnet ]
  subnet_id = aws_subnet.sid_public_subnet.id
  route_table_id = aws_route_table.sid_public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
  depends_on = [ aws_route_table.sid_private_route_table, aws_subnet.sid_private_subnet ]
  subnet_id = aws_subnet.sid_private_subnet.id
  route_table_id = aws_route_table.sid_private_route_table.id
}