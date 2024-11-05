output "lambda_function_arn" {
  value = aws_lambda_function.ec2_control.arn
}
output "lambda_role_name" {
  value = aws_iam_role.lambda_role.name  # Replace with the actual name of your IAM role resource
}
