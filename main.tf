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
  lambda_zip = "/home/ayman/terraform_eventb/lambda_python/lambda_function.zip"
}
module "eventbridge" {
  source = "./modules/eventbridge"  # Path to your EventBridge module
  lambda_function_arn = module.lambda.lambda_function_arn  # Pass the Lambda function ARN

}
