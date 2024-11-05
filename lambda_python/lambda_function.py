import json
import boto3
import os

# Initialize the SNS client
sns_client = boto3.client('sns')

# Hardcode the SNS topic ARN
sns_topic_arn = 'arn:aws:sns:us-east-1:968868672504:ec2_state_change'  # Replace with your SNS topic ARN

def lambda_handler(event, context):
    action = event['detail']['action']
    instance_id = os.environ['INSTANCE_ID']  # Retrieve the instance ID from environment variables
    ec2 = boto3.client('ec2')

    if action == 'stop':
        # Stop the EC2 instance
        ec2.stop_instances(InstanceIds=[instance_id])
        message = f'EC2 instance {instance_id} has been stopped.'
    elif action == 'start':
        # Start the EC2 instance
        ec2.start_instances(InstanceIds=[instance_id])
        message = f'EC2 instance {instance_id} has been started.'

    # Publish a message to the SNS topic
    sns_client.publish(
        TopicArn=sns_topic_arn,
        Message=message,
        Subject='EC2 State Change Notification'
    )

    return {
        'statusCode': 200,
        'body': json.dumps(f'Success: {message}')
    }
