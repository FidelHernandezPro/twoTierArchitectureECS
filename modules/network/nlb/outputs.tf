output "nlb_arn" {
  value = aws_lb.nlb.arn
}

output "nlb_dns_name" {
  value = aws_lb.nlb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.nlb_tg.arn
}

output "arn_suffix" {
  value = aws_lb.nlb.arn_suffix
}