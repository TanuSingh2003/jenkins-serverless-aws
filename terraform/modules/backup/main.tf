resource "aws_backup_vault" "this" {
  name = "notes-backup-vault"
}

resource "aws_backup_plan" "this" {
  name = "notes-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 5 * * ? *)" # daily 5 AM UTC
    lifecycle {
      delete_after = 7
    }
  }
}

resource "aws_backup_selection" "this" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "rds-selection"
  plan_id      = aws_backup_plan.this.id

  resources = [
    var.rds_arn
  ]
}

resource "aws_iam_role" "backup" {
  name = "backup-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "backup.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup" {
  role       = aws_iam_role.backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

