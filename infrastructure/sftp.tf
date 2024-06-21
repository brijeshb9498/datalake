resource "aws_transfer_server" "example" {
  endpoint_type = "VPC"

  endpoint_details {
    address_allocation_ids = [aws_eip.id]
    subnet_ids             = [aws_subnet.id]
    vpc_id                 = aws_vpc.id
    identity_provider_type = "SERVICE_MANAGED"
  tags = {
    Name = "SFTPServer"
  }
}
}
