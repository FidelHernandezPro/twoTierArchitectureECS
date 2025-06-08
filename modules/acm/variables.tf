variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)"
}

variable "domain_name" {
  type        = string
  description = "The domain name to secure"
}


variable "route53_zone_id" {}
