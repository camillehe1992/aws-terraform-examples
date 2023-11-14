# General Deployment Variables
env      = "prod"
nickname = "nginx"

tags = {
  environment      = "prod"
  nickname         = "nginx"
  application_name = "A nginx server that deployed in ECS Service with EC2 type"
  application_desc = "Create an ECS service for nginx in an existing ECS Cluster on EC2 type"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
vpc_id                            = "vpc-02fd20cf215e9a54b"
public_subnet_ids                 = ["subnet-05caf66e740964d47", "subnet-0ac7236fe344b9a9c"]
security_groups                   = ["sg-0579f97438569f812"]
ecs_cluster_name                  = "PROD-APP-ECS-CLUSTER"
image                             = "camillehe1992/nginx:latest"
health_check_grace_period_seconds = 60
desired_count                     = 1
min_capacity                      = 1
max_capacity                      = 4
cpu_utilization_target_value      = 75
cpu                               = 128
memory                            = 256
health_check                      = "/health"
container_port                    = 80

