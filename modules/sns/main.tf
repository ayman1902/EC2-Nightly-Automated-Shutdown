resource "aws_sns_topic" "ec2_state_change" {
  name = "ec2_state_change"
}
resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.ec2_state_change.arn  # Reference to your SNS topic
  protocol  = "lambda"
  endpoint  = var.lambda_arn  # Reference to your Lambda function
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.ec2_state_change.arn  # Correct reference
  protocol  = "email"
  endpoint  = var.email_endpoint  # Define this in variables.tf
}

resource "aws_iam_policy" "lambda_sns_policy" {
  name   = "LambdaSNSPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sns:Publish",
        ],
        Resource = aws_sns_topic.ec2_state_change.arn  # Correct reference
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_sns_attachment" {
  role       = var.lambda_role_name  # Pass the Lambda role name as a variable
  policy_arn = aws_iam_policy.lambda_sns_policy.arn
}
