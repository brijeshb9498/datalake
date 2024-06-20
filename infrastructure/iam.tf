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
          "arn:aws:s3:::my-data-lake-bucket",
          "arn:aws:s3:::my-data-lake-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sftp_role_attach" {
  role       = aws_iam_role.sftp_role.name
  policy_arn = aws_iam_policy.sftp_policy.arn
}
