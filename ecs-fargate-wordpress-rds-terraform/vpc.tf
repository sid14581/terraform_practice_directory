resource "aws_vpc" "ecs_fargate_wordpress_rds_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    name = "ecs-fargate-wordpress-rds-vpc"
  }
}

resource "aws_subnet" "ecs_fargate_wordpress_rds_subneta" {
  vpc_id            = aws_vpc.ecs_fargate_wordpress_rds_vpc.id
  cidr_block        = var.cidr_block_subnet_a
  availability_zone = "${var.region}a"

  tags = {
    name = "ecs-fargate-wordpress-rds-subnet-a"
  }

}
