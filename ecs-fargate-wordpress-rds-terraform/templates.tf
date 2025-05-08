data "template_file" "wordpress-container" {
  template = file("task-definitions/wordpress.json")

  vars = {
    db_host     = aws_db_instance.db.endpoint
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
    region      = var.region
  }
} 