output "service_name" {
  value = aws_ecs_service.this.name
}

output "cluster_id" {
  value = var.cluster_id
}