# General Deployment Variables
env      = "dev"
nickname = "network"

tags = {
  environment      = "dev"
  nickname         = "network"
  application_name = "three-layers-network"
  application_desc = "Create a AWS network infrasturcture that follows AWS Well-Archtected and best practice."
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
vpc_cidr_block       = "172.2.0.0/16"
private_subnet_cidrs = ["172.2.0.0/24", "172.2.64.0/24"]
public_subnet_cidrs  = ["172.2.128.0/24", "172.2.192.0/24"]
