# modules/eventbridge/variables.tf

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to be invoked."
  type        = string
}
