# General Deployment Variables
env      = "dev"
nickname = "nginx"

tags = {
  environment      = "dev"
  nickname         = "nginx"
  application_name = "A nginx server that deployed in ECS Service with EC2 type"
  application_desc = "Create an ECS service for nginx in an existing ECS Cluster on EC2 type"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
vpc_id                            = "vpc-06c47d9bb120348df"
public_subnet_ids                 = ["subnet-04839c488f31e2829", "subnet-08122d3fc6e3ce9b1"]
security_groups                   = ["sg-00fe42c9972b4e4af"]
ecs_cluster_name                  = "DEV-APP-ECS-CLUSTER"
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

