variable "environment" {
  type        = string
  description = "Environment name"
}

variable "alb_dns_name" {
  type        = string
  description = "DNS name of the internal ALB"
}

variable "nlb_target_group_arn" {
  type        = string
  description = "Target group ARN for NLB"
}


