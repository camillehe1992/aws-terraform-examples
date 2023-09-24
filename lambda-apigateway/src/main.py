import json


def lambda_handler(event, context):
    print(event)
    name = "World"
    if event.get("queryStringParameters") and event["queryStringParameters"]["Name"]:
        name = event["queryStringParameters"]["Name"]

    return {
        "statusCode": 200,
        "message": json.dumps(f"Hello from {name}!")
    }
