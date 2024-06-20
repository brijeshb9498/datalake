resource "aws_transfer_server" "sftp" {
  endpoint_type = "PUBLIC"
  identity_provider_type = "SERVICE_MANAGED"
  tags = {
    Name = "SFTPServer"
  }
}
