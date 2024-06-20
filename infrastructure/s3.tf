resource "aws_s3_bucket_lifecycle_configuration" "data_lake" {
  bucket = "my-data-lake-bucket"
  aws_s3_bucket_acl    = "private"

  rule {
    id      = "move-to-glacier"
    enabled = true

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}
