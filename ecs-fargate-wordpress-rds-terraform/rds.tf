resource "aws_db_subnet_group" "db_subnet_group" {
  name = "ecs-rds-subnet-group-tf"
  subnet_ids = [
    aws_subnet.ecs_fargate_wordpress_rds_subneta.id,
    aws_subnet.ecs_fargate_wordpress_rds_subnetb.id,
    aws_subnet.ecs_fargate_wordpress_rds_subnetc.id,
  ]
  description = "VPC Subnets"
}

resource "aws_db_instance" "db" {
  identifier        = "ecs-rds-instance-db"
  engine            = "mariaDB"
  engine_version    = "10.11"
  allocated_storage = 20
  port              = 3306
  storage_type      = "gp2"

  instance_class         = var.db_instance_type
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.ecs_fargate_wordpress_rds_sg.id]

  db_name  = var.db_name
  username = var.db_user
  password = var.db_password

  parameter_group_name = "default.mariadb10.11"
  multi_az             = false
  skip_final_snapshot  = true
  publicly_accessible  = true
}