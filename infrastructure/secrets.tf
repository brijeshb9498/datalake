resource "aws_secretsmanager_secret" "sftp1_secret" {
  name = "sftp/agency_user_password"
}

resource "aws_secretsmanager_secret_version" "sftp1_secret_value" {
  secret_id     = aws_secretsmanager_secret.sftp1_secret.id
  secret_string = jsonencode({
    password = "password35"
  })
}
