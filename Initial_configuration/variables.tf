variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
}

variable "table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
}