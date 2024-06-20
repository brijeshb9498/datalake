resource "aws_iam_role" "sftp_role" {
  name = "sftp-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "transfer.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "sftp_policy" {
  name = "sftp-access-policy"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::data-lake-bucket",
          "arn:aws:s3:::data-lake-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sftp_role_attach" {
  role       = aws_iam_role.sftp_role.name
  policy_arn = aws_iam_policy.sftp_policy.arn
}
resource "aws_transfer_user" "sftp_user" {
  user_name   = "agency_user"
  server_id   = aws_transfer_server.sftp1.id
  role        = aws_iam_role.sftp_role.arn
  home_directory = "/my-data-lake-bucket/agency_user"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:ListBucket"
        Resource = "arn:aws:s3:::data-lake-bucket"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::data-lake-bucket/agency_user/*"
      }
    ]
  })
}
