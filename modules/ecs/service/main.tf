resource "aws_ecs_service" "this" {
  name            = "${var.environment}-service"
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "${var.environment}-${var.container_name}"  
    container_port   = var.container_port
  }

  depends_on = [var.alb_listener]
}


