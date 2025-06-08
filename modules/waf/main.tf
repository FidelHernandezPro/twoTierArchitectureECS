
# ## This module creates an AWS WAFv2 Web ACL for CloudFront with a managed rule group.
resource "aws_wafv2_web_acl" "this" {
  name        = "${var.environment}-waf"
  description = "WAF for ${var.environment} CloudFront"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.environment}-waf-metrics"
    sampled_requests_enabled   = true
  }

  ###########################################
  # Managed Rule Group: Common Threats
  ###########################################
  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {} # Count mode (non-blocking) switch to "block" if needed
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.environment}-waf-common-rules"
      sampled_requests_enabled   = true
    }
  }

  #################################################
  # Managed Rule Group: Known Bad Inputs
  #################################################
  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 2

    override_action {
      none {} # Count mode (non-blocking) switch to "block" if needed
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.environment}-waf-known-bad"
      sampled_requests_enabled   = true
    }
  }

  #################################################
  # Managed Rule Group: SQL Injection (SQLi)
  #################################################
  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 3

    override_action {
      none {} # Count mode (non-blocking) switch to "block" if needed
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.environment}-waf-sqli"
      sampled_requests_enabled   = true
    }
  }

  tags = {
    Environment = var.environment
  }
}



