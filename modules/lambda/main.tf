resource "aws_iam_role" "lambda_role" {
  name               = "lambda_ec2_control_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "lambda_ec2_policy" {
  name        = "lambda_ec2_policy"
  description = "Policy to allow EC2 Start/Stop actions"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:StopInstances",
          "ec2:StartInstances",
        ],
        Resource = "arn:aws:ec2:${var.region}:${data.aws_caller_identity.current.account_id}:instance/${var.instance_id}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ec2_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_ec2_policy.arn
}

resource "aws_lambda_function" "ec2_control" {
  function_name = "ec2_control_function"
  runtime       = "python3.8"  # or your preferred version
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  timeout       = 30

  filename      = var.lambda_zip

  environment {
    variables = {
      INSTANCE_ID = var.instance_id  # Use this syntax to define environment variables
    }
  }
}
