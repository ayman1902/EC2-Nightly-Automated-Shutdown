import boto3
import os

ec2_client = boto3.client('ec2')

def lambda_handler(event, context):
    instance_id = os.environ['INSTANCE_ID']
    
    action = event['detail']['action']
    
    if action == 'stop':
        print(f"Stopping instance: {instance_id}")
        ec2_client.stop_instances(InstanceIds=[instance_id])
    elif action == 'start':
        print(f"Starting instance: {instance_id}")
        ec2_client.start_instances(InstanceIds=[instance_id])
    else:
        print("No action taken")
