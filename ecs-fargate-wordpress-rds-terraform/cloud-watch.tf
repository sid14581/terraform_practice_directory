resource "aws_cloudwatch_log_group" "ecs_fargate_wordpress_rds_log_group" {
  name              = "/ecs/wp-ecs-tf"
  retention_in_days = 7

  tags = {
    Name        = "ecs-fargate-wordpress-rds-log-group"
    Environment = "production"
    Application = "wp"
  }
}