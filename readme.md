# EC2 Nightly Automated Shutdown

![Architecture Diagram]("images/diagram-export-04-11-2024-02_29_26.png")
## Overview

This project automates the nightly shutdown of EC2 instances using AWS Lambda and EventBridge, all provisioned with Terraform. The system is designed to:

- **Trigger**: An EventBridge rule is scheduled to trigger every day at a specific time (e.g., 10 PM).
- **Lambda Function**: The triggered EventBridge rule invokes a Lambda function.
- **EC2 Instance Shutdown**: The Lambda function utilizes the AWS SDK for Python (Boto3) to stop the specified EC2 instances.

## Prerequisites

- An AWS account with necessary permissions.
- Terraform installed and configured.
- Basic understanding of AWS services (EC2, Lambda, EventBridge, IAM).

## Terraform Configuration

The Terraform configuration defines the following resources:

- **IAM Role**: Grants the Lambda function permission to stop EC2 instances.
- **Lambda Function**: Contains the Python code to stop the EC2 instances.
- **EventBridge Rule**: Schedules the Lambda function to trigger daily.
- **EC2 Instances**: The instances to be shut down.