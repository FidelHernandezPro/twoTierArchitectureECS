

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.app.arn
}

output "container_port" {
  description = "Container port for the ECS task"
  value       = var.container_port
}

output "task_cpu" {
  description = "CPU units for the ECS task"
  value       = var.task_cpu
}

output "task_memory" {
  description = "Memory for the ECS task"
  value       = var.task_memory
}

output "image_url" {
  description = "Container image URI"
  value       = var.image_url
}
