# General Deployment Variables
environment = "prod"
nickname    = "fluentd"

tags = {
  environment      = "prod"
  nickname         = "fluentd"
  application_name = "A fluentd daemon task that deployed in ECS Service with EC2 type"
  application_desc = "Create an ECS service for nginx in an existing ECS Cluster on EC2 type"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
vpc_id               = "vpc-02fd20cf215e9a54b"
public_subnet_ids    = ["subnet-05caf66e740964d47", "subnet-0ac7236fe344b9a9c"]
security_groups      = ["sg-0579f97438569f812"]
ecs_cluster_name     = "PROD-APP-ECS-CLUSTER"
firehose_bucket_name = ""
