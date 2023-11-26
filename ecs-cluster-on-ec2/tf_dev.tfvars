# General Deployment Variables
environment = "dev"
nickname    = "ecs-cluster-on-ec2"

tags = {
  environment      = "dev"
  nickname         = "ecs-cluster-on-ec2"
  application_name = "ECS Cluster with EC2 type"
  application_desc = "Create a ECS Cluster with EC2 type for containerized applications"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
image_id       = "ami-01cf7955aaf2c5a18" # ECS optimaized arm64
subnet_ids     = ["subnet-04839c488f31e2829", "subnet-08122d3fc6e3ce9b1"]
security_group = "sg-00fe42c9972b4e4af"
