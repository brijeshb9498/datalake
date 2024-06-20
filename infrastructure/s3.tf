resource "aws_s3_bucket_lifecycle_configuration" "data_lake" {
  bucket = "my-data-lake-bucket"

  rule {
    
    id      = "move-to-glacier"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDERD_IA"
    }
    trasition {
      days          = 365
      storage_class = "GLACIER"
  }

    status = "enabled"
}
}
