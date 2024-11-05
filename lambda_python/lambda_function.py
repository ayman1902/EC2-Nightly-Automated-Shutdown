import json
import boto3
import os  # Import os to access environment variables

def lambda_handler(event, context):
    action = event['detail']['action']
    instance_id = os.environ['INSTANCE_ID']  # Retrieve the instance ID from environment variables
    ec2 = boto3.client('ec2')

    if action == "stop":
        ec2.stop_instances(InstanceIds=[instance_id])
        return {
            'status': 'completed',
            'action': 'stop',
            'instance_id': instance_id
        }
    elif action == "start":
        ec2.start_instances(InstanceIds=[instance_id])
        return {
            'status': 'completed',
            'action': 'start',
            'instance_id': instance_id
        }
    else:
        return {
            'status': 'failed',
            'error': 'Invalid action'
        }
