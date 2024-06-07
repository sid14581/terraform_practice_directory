resource "aws_security_group" "sid_sg" {
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    self             = false
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    description      = ""

  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    self             = false
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    description      = ""

  }]
  vpc_id     = aws_vpc.sid_vpc.id
  depends_on = [aws_vpc.sid_vpc]
  tags = {
    Name = "sid_sg"
  }
}