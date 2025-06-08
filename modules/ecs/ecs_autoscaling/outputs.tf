output "autoscaling_policy_arn" {
  value = aws_appautoscaling_policy.cpu_target.arn
}
