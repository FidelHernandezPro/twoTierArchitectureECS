output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}


output "listener_arn" {
  value = aws_lb_listener.http.arn
}


output "target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}


output "arn_suffix" {
  value = aws_lb.alb.arn_suffix
}