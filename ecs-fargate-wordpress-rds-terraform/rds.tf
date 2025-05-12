resource "aws_db_subnet_group" "db_subnet_group" {
  name = "ecs-rds-subnet-group-tf"
  subnet_ids = [
    aws_subnet.ecs_fargate_wordpress_rds_subneta.id,
    aws_subnet.ecs_fargate_wordpress_rds_subnetb.id,
    aws_subnet.ecs_fargate_wordpress_rds_subnetc.id,
  ]
  description = "VPC Subnets"
}

resource "aws_db_instance" "my_mariadb_db" {
  identifier             = var.identifier
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  port                   = var.db_port
  instance_class         = var.db_instance_type
  db_name                = var.db_name
  username               = var.db_user
  password               = var.db_password
  multi_az               = var.multi_az
  vpc_security_group_ids = ["${aws_security_group.ecs_fargate_wordpress_rds_sg.id}"]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  parameter_group_name   = var.parameter_group_name
  publicly_accessible    = true
  skip_final_snapshot    = true
}