# General Deployment Variables
environment = "prod"
nickname    = "ecs-cluster-on-ec2"

tags = {
  environment      = "prod"
  nickname         = "ecs-cluster-on-ec2"
  application_name = "ECS Cluster with EC2 type"
  application_desc = "Create a ECS Cluster with EC2 type for containerized applications"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
image_id       = "ami-0cb636837b2167e1d" # ECS optimaized arm64
subnet_ids     = ["subnet-05caf66e740964d47", "subnet-0ac7236fe344b9a9c"]
security_group = "sg-0579f97438569f812"
