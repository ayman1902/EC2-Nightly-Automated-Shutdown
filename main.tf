# Configure S3 backend for storing state
terraform {
  backend "s3" {
    bucket         = "s3-bucket-backendd"
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "dynamodb-lock-table"
    encrypt        = true
  }
}

# Call EC2 module
module "ec2" {
  source         = "./modules/ec2"
  ami            = var.ami
  instance_type  = var.instance_type
  instance_name  = var.instance_name
  availability_zone = var.availability_zone  # Pass this variable
}
