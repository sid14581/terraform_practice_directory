output "alb_dns" {
  value = aws_lb.ecs_fargate_wordpress_rds_alb.dns_name
}