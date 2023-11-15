from os import environ as env
import time
import json
import boto3

ECS_CLUSTER_ARN = env.get("ECS_CLUSTER_ARN")
REGION = env.get("AWS_REGION")

ECS = boto3.client("ecs", region_name=REGION)
ASG = boto3.client("autoscaling", region_name=REGION)


def lambda_handler(event, context):
    pass
