
output "task_role_arn" {
  value = aws_iam_role.task_role.arn
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_execution_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}