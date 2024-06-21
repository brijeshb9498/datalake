import boto3
import json
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        response = s3.get_object(Bucket=bucket, Key=key)
        file_content = response['Body'].read().decode('utf-8')
      
        print(f"Processed file: {key} from bucket: {bucket}")
    return {
        'statusCode': 200,
        'body': json.dumps('File processed successfully!')
    }
