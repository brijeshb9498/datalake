resource "aws_s3_bucket" "data_lake1" {
  bucket = "data-lake-bucket"
  acl    = "private"

  lifecycle_rule {
    id      = "move-to-glacier"
    enabled = true

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}
