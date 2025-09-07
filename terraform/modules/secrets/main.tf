resource "aws_secretsmanager_secret" "db" {
  name = "notes-db-credentials"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id     = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = "postgres",
    password = "Postgres123!"
  })
}

output "secret_arn" {
  value = aws_secretsmanager_secret.db.arn
}

