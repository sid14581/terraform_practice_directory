import json
import boto3

def list_s3_bucket_using_lambda(event, context):
    s3 = boto3.client('s3')
    try:
        response = s3.list_buckets()
        bucket_names = [bucket['Name'] for bucket in response in response['Buckets']]
        return{
            'statusCode': 200,
            'body': json.dumps(bucket_names)
        }
    except Exception as e:
      return{
            'statusCode': 200,
            'body': json.dumps({'error':str(e)})
        }