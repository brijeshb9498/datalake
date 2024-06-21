resource "aws_transfer_server" "sftp" {
  endpoint_type = "VPC"

  endpoint_details {
    address_allocation_ids = [aws_eip.sftp.id]
    subnet_ids             = [aws_subnet.sftp.id]
    vpc_id                 = aws_vpc.sftp.id
    identity_provider_type = "SERVICE_MANAGED"
  tags = {
    Name = "SFTPServer"
  }
}
}
