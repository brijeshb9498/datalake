resource "aws_secretsmanager_secret" "sftp_secret" {
  name = "sftp/agency_user_password"
}

resource "aws_secretsmanager_secret_version" "sftp_secret_value" {
  secret_id     = aws_secretsmanager_secret.sftp_secret.id
  secret_string = jsonencode({
    password = "example_password"
  })
}
