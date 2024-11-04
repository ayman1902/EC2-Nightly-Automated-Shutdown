resource "aws_s3_bucket" "state" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }
}
