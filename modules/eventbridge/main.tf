# modules/eventbridge/main.tf

resource "aws_cloudwatch_event_rule" "stop_ec2" {
  name        = "StopEC2EventRule"
  description = "Trigger Lambda function to stop EC2 instance"
  schedule_expression = "cron(14 1 * * ? *)"  # This triggers at 01:52 every day

}

resource "aws_cloudwatch_event_rule" "start_ec2" {
  name        = "StartEC2EventRule"
  description = "Trigger Lambda function to start EC2 instance"
  schedule_expression = "cron(17 1 * * ? *)" # This triggers at 01:10 every day
}

resource "aws_cloudwatch_event_target" "stop_ec2_target" {
  rule      = aws_cloudwatch_event_rule.stop_ec2.name
  target_id = "StopEC2"
  arn       = var.lambda_function_arn # Use the variable for Lambda function ARN
  input     = jsonencode({
    "detail": {
        "action": "stop"
    }
})  # Pass the action

}

resource "aws_cloudwatch_event_target" "start_ec2_target" {
  rule      = aws_cloudwatch_event_rule.start_ec2.name
  target_id = "StartEC2"
  arn       = var.lambda_function_arn # Use the variable for Lambda function ARN
  input     = jsonencode({
    "detail": {
        "action": "start"
    }
})  # Pass the action
}

# IAM Role for EventBridge to invoke Lambda
resource "aws_lambda_permission" "allow_eventbridge_stop" {
  statement_id  = "AllowExecutionFromEventBridgeStop"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_ec2.arn
}

resource "aws_lambda_permission" "allow_eventbridge_start" {
  statement_id  = "AllowExecutionFromEventBridgeStart"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_ec2.arn
}
