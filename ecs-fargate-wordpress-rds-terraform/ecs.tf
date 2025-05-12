resource "aws_ecs_cluster" "ecs_fargate_wordpress_rds_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "ecs_fargate_wordpress_rds_task" {
  family                   = var.ecs_task_family_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = data.template_file.wordpress-container.rendered
}

resource "aws_ecs_service" "ecs_fargate_wordpress_rds_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_fargate_wordpress_rds_cluster.id
  task_definition = aws_ecs_task_definition.ecs_fargate_wordpress_rds_task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.ecs_fargate_wordpress_rds_subneta.id, aws_subnet.ecs_fargate_wordpress_rds_subnetb.id, aws_subnet.ecs_fargate_wordpress_rds_subnetc.id]
    security_groups  = [aws_security_group.ecs_fargate_wordpress_alb_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_fargate_wordpress_rds_target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}