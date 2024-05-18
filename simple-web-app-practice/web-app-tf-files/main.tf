

# RESOURCE FOR S3 BUCKET
resource "aws_s3_bucket" "damdam-dingdong-bucket" {
  bucket = var.bucket
  tags = {
    "name" = var.bucket
  }
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "damdam-dingdong-versioning" {
  bucket = aws_s3_bucket.damdam-dingdong-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "damdam-dingdong-crypto" {
  bucket = aws_s3_bucket.damdam-dingdong-bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}

# VPC
resource "aws_vpc" "demoVPC" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

# SUBNET
resource "aws_subnet" "demo_subenet_1" {
  vpc_id                  = aws_vpc.demoVPC.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "demo_subenet_2" {
  vpc_id                  = aws_vpc.demoVPC.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}


# INTERNET GATEWAY
resource "aws_internet_gateway" "demoIGW" {
  vpc_id = aws_vpc.demoVPC.id
  tags = {
    Name = var.igw_name
  }
}

# ROUTE TABLE
resource "aws_route_table" "demoRouteTable" {
  vpc_id = aws_vpc.demoVPC.id

  route {
    cidr_block = var.cidr_block_0
    gateway_id = aws_internet_gateway.demoIGW.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.demo_subenet_1.id
  route_table_id = aws_route_table.demoRouteTable.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.demo_subenet_2.id
  route_table_id = aws_route_table.demoRouteTable.id
}


# SECURITY GROUPS 
locals {
  ingress_rule = [{
    port        = 80
    description = var.description_http
    },
    {
      port        = 22
      description = var.description_ssh
  }]
}

resource "aws_security_group" "demoSG" {
  name   = var.sg_name
  vpc_id = aws_vpc.demoVPC.id
  tags = {
    Name = var.sg_tag_name
  }

  egress = [{
    cidr_blocks      = [var.cidr_block_0, ]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    self             = false
    description      = ""
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []

  }]
  dynamic "ingress" {
    for_each = local.ingress_rule

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = [var.cidr_block_0, ]
    }
  }
}


#  INSTANCES
resource "aws_instance" "webserver1" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.instance_tag_name1
  }
  subnet_id              = aws_subnet.demo_subenet_1.id
  vpc_security_group_ids = [aws_security_group.demoSG.id]
  user_data              = base64encode(file("./userdata.sh"))
}

resource "aws_instance" "webserver2" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.instance_tag_name2
  }
  subnet_id              = aws_subnet.demo_subenet_2.id
  vpc_security_group_ids = [aws_security_group.demoSG.id]
  user_data              = base64encode(file("./userdata1.sh"))
}


# LOAD BALANCER
resource "aws_lb" "demoALB" {
  name               = var.load_balancer_name
  internal           = false # public
  load_balancer_type = var.load_balancer_type
  tags = {
    Name = var.load_balancer_tag_name
  }
  security_groups = [aws_security_group.demoSG.id]
  subnets         = [aws_subnet.demo_subenet_1.id, aws_subnet.demo_subenet_2.id]
}

# TARGET GROUP
resource "aws_lb_target_group" "demo_target_demo" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demoVPC.id
  health_check {
    path = "/"
    port = var.target_group_heathcheck_port
  }
}

resource "aws_lb_target_group_attachment" "attach1" {
  port             = 80
  target_group_arn = aws_lb_target_group.demo_target_demo.arn
  target_id        = aws_instance.webserver1.id
}

resource "aws_lb_target_group_attachment" "attach2" {
  port             = 80
  target_group_arn = aws_lb_target_group.demo_target_demo.arn
  target_id        = aws_instance.webserver2.id
}

resource "aws_lb_listener" "demoListner" {
  load_balancer_arn = aws_lb.demoALB.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.demo_target_demo.arn
    type             = "forward"
  }
}

# RDS DATABASE
resource "aws_db_instance" "db_instance" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = true
}