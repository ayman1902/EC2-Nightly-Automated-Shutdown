variable "lambda_role_name" {
  description = "The name of the Lambda execution role."
  type        = string
}

variable "email_endpoint" {
  description = "The email endpoint for SNS subscriptions."
  type        = string
}
variable "lambda_arn" {
  description = "ARN of the Lambda function"
  type        = string
}
