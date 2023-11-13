# General Deployment Variables
env      = "prod"
nickname = "ecs-cluster-on-ec2"

tags = {
  environment      = "prod"
  nickname         = "ecs-cluster-on-ec2"
  application_name = "ECS Cluster with EC2 type"
  application_desc = "Create a ECS Cluster with EC2 type for containerized applications"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
ecs_cluster_name          = "app-ecs-cluster"
image_id                  = "ami-0f80211f2590b9c3d" # ECS optimaized arm64
instance_type             = "t4g.micro"
asg_max_size              = 2
asg_min_size              = 0
asg_desired_size          = 0
health_check_grace_period = 300
subnet_ids                = ["subnet-05caf66e740964d47", "subnet-0ac7236fe344b9a9c"]
security_group            = "sg-0579f97438569f812"
