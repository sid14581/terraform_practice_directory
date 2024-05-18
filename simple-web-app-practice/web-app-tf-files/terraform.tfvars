cidr_block_0 = "0.0.0.0/0"
ami = "ami-0cd59ecaf368e5ccf"
instance_type = "t2.micro"

# RDS DATABASE
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name