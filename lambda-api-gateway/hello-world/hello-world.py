import json


def lambda_handler(event, context):
    print(event)
    return {
        "statusCode": 200,
        "message": json.dumps("Hello from Lambda!")
    }
