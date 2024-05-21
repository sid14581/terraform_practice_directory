module "web-server-1" {
  source               = ".//module1"
  ami                  = var.ami
  web-instance-type    = var.web-instance-type
  aws_key_pair_keyName = var.aws_key_pair_keyName
}


module "web-server-2" {
  source = ".//module2"
  ami = var.ami
  web-instance-type = var.web-instance-type
  aws_key_pair_keyName = var.aws_key_pair_keyName
}