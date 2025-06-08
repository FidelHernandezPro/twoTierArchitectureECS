output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output web_acl_id{
  value = var.web_acl_id
}