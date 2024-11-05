# Configure S3 backend for storing state
terraform {
  backend "s3" {
    bucket         = "s3-bucket-backendd"
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "dynamodb-lock-table"
    encrypt        = true
  }
}

# Call EC2 module
module "ec2" {
  source         = "./modules/ec2"
  ami            = var.ami
  instance_type  = var.instance_type
  instance_name  = var.instance_name
  availability_zone = var.availability_zone  # Pass this variable
}
#lambda function
module "lambda" {
  source     = "./modules/lambda"  # Path to your lambda module
  instance_id = module.ec2.instance_id     # Pass your EC2 instance ID
  lambda_zip = "/home/ayman/terraform_eventb/lambda_python/lambda_functionu.zip"
  sns_topic_arn   = module.sns.ec2_state_change_topic  # Directly use the output

}

module "sns" {
  source          = "./modules/sns"
  lambda_role_name = module.lambda.lambda_role_name  # Pass the Lambda role name
  lambda_arn    = module.lambda.lambda_function_arn
  email_endpoint  = "belhajaymanjs5@gmail.com"
  # Replace with the actual email
}

module "eventbridge" {
  source               = "./modules/eventbridge"
  lambda_function_arn  = module.lambda.lambda_function_arn  # Pass the Lambda function ARN
  sns_topic_arn       = module.sns.ec2_state_change_topic  # Pass the SNS topic ARN from the SNS module
}
