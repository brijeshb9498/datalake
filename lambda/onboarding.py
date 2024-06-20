import boto3
import json

transfer = boto3.client('transfer')
iam = boto3.client('iam')

def create_user(user_name):
    response = transfer.create_user(
        UserName=user_name,
        ServerId='s-xxxxxxxxxx',  # Replace with actual server ID
        Role='arn:aws:iam::123456789012:role/sftp-access-role',
        HomeDirectory='/my-data-lake-bucket/' + user_name,
        Policy=json.dumps({
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": "s3:ListBucket",
                    "Resource": "arn:aws:s3:::my-data-lake-bucket"
                },
                {
                    "Effect": "Allow",
                    "Action": [
                        "s3:GetObject",
                        "s3:PutObject"
                    ],
                    "Resource": f"arn:aws:s3:::my-data-lake-bucket/{user_name}/*"
                }
            ]
        })
    )
    return response

def delete_user(user_name):
    response = transfer.delete_user(
        UserName=user_name,
        ServerId='s-xxxxxxxxxx'  # Replace with actual server ID
    )
    return response

def lambda_handler(event, context):
    action = event['action']
    user_name = event['user_name']
    if action == 'create':
        create_user(user_name)
    elif action == 'delete':
        delete_user(user_name)
    return {
        'statusCode': 200,
        'body': json.dumps(f"User {user_name} {action}d successfully!")
    }
