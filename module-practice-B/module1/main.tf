resource "aws_instance" "ec2_module_1" {
  ami                    = var.ami
  instance_type          = var.web-instance-type
  key_name               = aws_key_pair.module-1-key.id
  vpc_security_group_ids = [aws_security_group.main-sg-module1.id]

  user_data = <<-EOF
      #!/bin/bash
      sudo apt-get update
      sudo apt install -y apache2

      sudo systemctl status apache2
      sudo systemctl start apache2
      
      mkdir -p /var/www/html
      sudo chown -R $USER:$USER /var/www/html
      
      sudo echo "<html><body><h1>Hello this is module-1 at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` 
      </h1></body></html>" > /var/www/html/index.html
  EOF
}

resource "aws_security_group" "main-sg-module1" {
  name        = "Ec2-webserver-SG1"
  description = "Webserver for EC2 Instances"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = 0
    to_port          = 0
    self             = false
    protocol         = "-1"
    description      = ""
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    }
  ]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0", ]
    from_port        = 80
    to_port          = 80
    self             = false
    protocol         = "tcp"
    description      = ""
    ipv6_cidr_blocks = []
    security_groups  = []
    prefix_list_ids  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      from_port        = 22
      to_port          = 22
      self             = false
      protocol         = "tcp"
      description      = ""
      ipv6_cidr_blocks = []
      security_groups  = []
      prefix_list_ids  = []
  }]
}

resource "aws_key_pair" "module-1-key" {
  key_name   = var.aws_key_pair_keyName
  public_key = file("../damdam_dingdong.pub")
}