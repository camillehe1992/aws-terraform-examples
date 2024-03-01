# General Deployment Variables
environment = "prod"
nickname    = "lambda-layers"

tags = {
  environment      = "prod"
  nickname         = "lambda-layers"
  application_name = "lambda-layers"
  application_desc = "Build a Lambda layer with external dependencies only for Lambda function"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
s3_bucket = "terraform-state-ap-southeast-1-bucket"
