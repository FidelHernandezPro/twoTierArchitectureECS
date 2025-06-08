
# This module creates an ECS task definition for a Fargate service.
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.environment}-${var.container_name}"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = var.task_cpu
  memory                  = var.task_memory
  execution_role_arn      = var.execution_role_arn
  container_definitions   = jsonencode([
    {
      name      = "${var.environment}-${var.container_name}"
      image     = var.image_url
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      environment = var.container_environment

    }
  ])

  tags = {
    Environment = var.environment
  }
}
