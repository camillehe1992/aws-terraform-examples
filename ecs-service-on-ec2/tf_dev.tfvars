# General Deployment Variables
env      = "dev"
nickname = "nginx"

tags = {
  environment      = "dev"
  nickname         = "strapi"
  application_name = "ECS Service with EC2 type"
  application_desc = "Create an ECS service in an existing ECS Cluster on EC2 type"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
vpc_id                            = "vpc-06c47d9bb120348df"
ecs_cluster_arn                   = "arn:aws-cn:ecs:cn-north-1:756143471679:cluster/DEV-APP-ECS-CLUSTER"
desired_count                     = 1
image                             = "camillehe1992/nginx:latest"
security_groups                   = ["sg-00fe42c9972b4e4af"]
public_subnet_ids                 = ["subnet-04839c488f31e2829", "subnet-08122d3fc6e3ce9b1"]
health_check_grace_period_seconds = 60
cpu                               = 128
memory                            = 256

