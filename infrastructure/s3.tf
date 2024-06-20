resource "aws_s3_bucket_lifecycle_configuration" "data_lake" {
  bucket = "my-data-lake-bucket"

  rule {
    
    id      = "move-to-glacier"
    
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 365
      storage_class = "GLACIER"
  }

    status = "Enabled"
}
}
