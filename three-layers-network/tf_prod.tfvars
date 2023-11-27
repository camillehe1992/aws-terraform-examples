# General Deployment Variables
environment = "prod"
nickname    = "network"

tags = {
  environment      = "prod"
  nickname         = "network"
  application_name = "three-layers-network"
  application_desc = "Create an AWS network infrasturcture that follows AWS Well-Archtected and best practice."
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
vpc_cidr_block       = "10.8.0.0/16"
private_subnet_cidrs = ["10.8.0.0/24", "10.8.64.0/24"]
public_subnet_cidrs  = ["10.8.128.0/24", "10.8.192.0/24"]
