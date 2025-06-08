variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "alb_ingress_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to access the ALB"
}

variable "app_port" {
  type        = number
  description = "Port ECS containers listen on"
}
