resource "aws_ecs_cluster" "this" {
  name = "${var.environment}-ecs-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "default" {
  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = ["FARGATE"]
}

