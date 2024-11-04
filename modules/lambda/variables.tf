variable "instance_id" {
  description = "The ID of the EC2 instance to start/stop"
  type        = string
}
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"  # or whatever region you are using
}
variable "lambda_zip" {
  description = "Path to the Lambda function ZIP file"
  type        = string
}