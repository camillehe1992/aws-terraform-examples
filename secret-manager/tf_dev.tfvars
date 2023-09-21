# General Deployment Variables
aws_region = "cn-north-1"
env        = "dev"
nickname   = "secretmanagerdemo"

tags = {
  environment      = "dev"
  nickname         = "secretmanagerdemo"
  emails           = "group@example.com"
  application_name = "Deploy Serects from GitHub Actions secret to Serect Manager"
}

