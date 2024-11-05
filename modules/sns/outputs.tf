output "ec2_state_change_topic" {
  value = aws_sns_topic.ec2_state_change.arn  # Adjust to your SNS topic resource
}
