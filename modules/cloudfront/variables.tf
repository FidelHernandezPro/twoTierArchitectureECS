variable "environment" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "origin_domain_name" {
  type = string
}

variable "web_acl_id" {
  description = "The ID of the WAF Web ACL to associate with this CloudFront distribution"
  type        = string
  default     = null
}