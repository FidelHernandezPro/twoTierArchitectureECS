resource "aws_backup_vault" "this" {
  name        = "${var.environment}-backup-vault"
  kms_key_arn = null  # Or specify a KMS key
  tags        = var.tags
}

resource "aws_backup_plan" "this" {
  name = "${var.environment}-backup-plan"

  rule {
    rule_name         = "${var.environment}-daily-backup"
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 5 * * ? *)" # Daily at 5am UTC
    start_window      = 60
    completion_window = 180

    lifecycle {
      delete_after = 30
    }
  }

  tags = var.tags
}

resource "aws_backup_selection" "rds" {
  name         = "${var.environment}-rds-selection"
  iam_role_arn = var.backup_role_arn
  plan_id      = aws_backup_plan.this.id

  resources = [
    var.rds_arn
  ]
}
