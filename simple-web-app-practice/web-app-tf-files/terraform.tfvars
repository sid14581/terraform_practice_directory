cidr_block_0  = "0.0.0.0/0"
ami           = "ami-0e001c9271cf7f3b9"
instance_type = "t2.micro"

# RDS DATABASE
allocated_storage    = 10
db_name              = "mydb"
engine               = "mysql"
engine_version       = "8.0"
instance_class       = "db.t3.micro"
username             = "foo"
password             = "foobarbaz"
parameter_group_name = "default.mysql8.0"