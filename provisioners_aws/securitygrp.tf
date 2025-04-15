resource "aws_security_group" "provision_sgp" {
  name   = var.sgp_name
  vpc_id = aws_vpc.provision_vpc.id

  ingress = [{ description = "HTTP from VPC"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] },
    { description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] }]

  egress = [{ from_port = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  tags = {
    Name = "Web-sg"
  }
}