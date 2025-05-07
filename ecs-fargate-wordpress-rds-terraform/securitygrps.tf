
# SECURITY GROUPS FOR ALB
resource "aws_security_group" "ecs_fargate_wordpress_alb_sg" {
  name        = var.ecs_security_group_alb_name
  description = "Security group for ALB"
  vpc_id      = aws_vpc.ecs_fargate_wordpress_rds_vpc.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "HTTP access"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow all outbound traffic"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
  tags = {
    Name = var.ecs_security_group_alb_name
  }
}

# SECURITY GROUPS FOR RDS
resource "aws_security_group" "ecs_fargate_wordpress_rds_sg" {
  name        = var.ecs_security_group_rds_name
  description = "Security group for RDS"
  vpc_id      = aws_vpc.ecs_fargate_wordpress_rds_vpc.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "RDS access"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow all outbound traffic"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
  tags = {
    Name = var.ecs_security_group_rds_name
  }
}   