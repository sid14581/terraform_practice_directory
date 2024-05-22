resource "aws_instance" "EC2_instance_module2" {
  ami                    = var.ami
  instance_type          = var.web-instance-type
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.module2_security_group.id]

  user_data = <<-EOF
      sudo apt-get update
      sudo apt-get install -y apache2
      
      sudo systemctl status apache2
      suso systemctl start apache2

      mkdir -p /var/www/html
      sudo chown -R $USER:$USER /var/www/html

      sudo echo "<html><body><h1>Hello this is module-2 at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` 
      </h1></body></html>" > /var/www/html/index.html
  EOF
}

resource "aws_security_group" "module2_security_group" {
  name        = "EC2-webserver-SG2"
  description = "Webserver for EC2 Instances"

  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    self             = false
    description      = ""
    security_groups  = []
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    self             = false
    description      = ""
    security_groups  = []
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      self             = false
      description      = ""
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
  }]

}

resource "aws_key_pair" "name" {
  key_name   = var.aws_key_pair_keyName
  public_key = file("../damdam_dingdong.pub")
}