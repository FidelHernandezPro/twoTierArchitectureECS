resource "aws_ssm_parameter" "this" {
  for_each = var.parameters

  name        = each.key
  type        = "SecureString"
  value       = each.value
  overwrite   = true
  description = "Managed by Terraform"

  tags = {
    Environment = var.environment
  }
}
