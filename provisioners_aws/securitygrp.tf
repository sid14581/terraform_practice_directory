resource "aws_security_group" "provision_sgp" {
  name   = var.sgp_name
  vpc_id = aws_vpc.provision_vpc.id

  ingress = [
    {
      description      = "HTTP from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      self             = false
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      self             = false
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
    }
  ]

  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      self             = false
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      description      = ""
    }
  ]

  tags = {
    Name = "Web-sg"
  }
}