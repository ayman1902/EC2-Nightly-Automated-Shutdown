# Call S3 backend module
module "s3_backend" {
  source      = "./modules/s3_backend"
  bucket_name = var.bucket_name
}

# Call DynamoDB module for state locking
module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = var.table_name
}
