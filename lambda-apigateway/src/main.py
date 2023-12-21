import json


def lambda_handler(event, context):
    print(event)
    name = "World"
    if event.get("queryStringParameters") and event["queryStringParameters"]["Name"]:
        name = event["queryStringParameters"]["Name"]

    return {
        "statusCode": 200,
        "body": json.dumps({"statusCode": 200, "data": f"Hello from {name}!"}),
        "isBase64Encoded": False,
    }
