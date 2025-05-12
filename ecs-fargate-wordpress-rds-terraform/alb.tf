resource "aws_lb" "ecs_fargate_wordpress_rds_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_fargate_wordpress_alb_sg.id]
  subnets            = [aws_subnet.ecs_fargate_wordpress_rds_subneta.id, aws_subnet.ecs_fargate_wordpress_rds_subnetb.id, aws_subnet.ecs_fargate_wordpress_rds_subnetc.id]

  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "ecs_fargate_wordpress_rds_target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ecs_fargate_wordpress_rds_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb_listener" "ecs_fargate_wordpress_rds_listener" {
  load_balancer_arn = aws_lb.ecs_fargate_wordpress_rds_alb.arn
  port              = var.target_group_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_fargate_wordpress_rds_target_group.arn
  }
}