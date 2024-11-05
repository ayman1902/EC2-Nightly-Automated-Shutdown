# modules/eventbridge/variables.tf

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to be invoked."
  type        = string
}
variable "sns_topic_arn" {
  description = "The ARN of the SNS topic to publish EC2 state change notifications."
  type        = string
}
