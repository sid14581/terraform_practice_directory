
# VPC
resource "aws_vpc" "ecs_fargate_wordpress_rds_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    name = var.vpc_name
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "ecs_fargate_wordpress_rds_igw" {
  vpc_id = aws_vpc.ecs_fargate_wordpress_rds_vpc.id

  tags = {
    name = var.igw_name
  }
}

# SUBNETS
resource "aws_subnet" "ecs_fargate_wordpress_rds_subneta" {
  vpc_id            = aws_vpc.ecs_fargate_wordpress_rds_vpc.id
  cidr_block        = var.cidr_block_subnet_a
  availability_zone = "${var.region}a"

  tags = {
    name = var.subnet_a_name
  }
}

resource "aws_subnet" "ecs_fargate_wordpress_rds_subnetb" {
  vpc_id            = aws_vpc.ecs_fargate_wordpress_rds_vpc.id
  cidr_block        = var.cidr_block_subnet_b
  availability_zone = "${var.region}b"

  tags = {
    name = var.subnet_b_name
  }
}

resource "aws_subnet" "ecs_fargate_wordpress_rds_subnetc" {
  vpc_id            = aws_vpc.ecs_fargate_wordpress_rds_vpc.id
  cidr_block        = var.cidr_block_subnet_c
  availability_zone = "${var.region}c"

  tags = {
    name = var.subnet_c_name
  }
}


# ROUTE TABLE
resource "aws_route_table" "ecs_fargate_wordpress_rds_route_table" {
  vpc_id = aws_vpc.ecs_fargate_wordpress_rds_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs_fargate_wordpress_rds_igw.id
  }

  tags = {
    name = var.route_table_name
  }
}


# ROUTE TABLE ASSOCIATIONS
resource "aws_route_table_association" "routea" {
  subnet_id      = aws_subnet.ecs_fargate_wordpress_rds_subneta.id
  route_table_id = aws_route_table.ecs_fargate_wordpress_rds_route_table.id
}

resource "aws_route_table_association" "routeb" {
  subnet_id      = aws_subnet.ecs_fargate_wordpress_rds_subnetb.id
  route_table_id = aws_route_table.ecs_fargate_wordpress_rds_route_table.id
}

resource "aws_route_table_association" "routec" {
  subnet_id      = aws_subnet.ecs_fargate_wordpress_rds_subnetc.id
  route_table_id = aws_route_table.ecs_fargate_wordpress_rds_route_table.id
}


