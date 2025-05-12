data "template_file" "wordpress-container" {
  template = file("C:\\A_my files\\DEVOPS\\Terraform\\terraform_practice_directory\\ecs-fargate-wordpress-rds-terraform\\task-definitions\\wordpress.json")

  vars = {
    db_host     = "${aws_db_instance.my_mariadb_db.address}"
    db_name     = "${var.db_name}"
    db_user     = "${var.db_user}"
    db_password = "${var.db_password}"
    region      = "${var.region}"
  }
} 