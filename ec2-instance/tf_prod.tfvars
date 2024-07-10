# General Deployment Variables
environment = "prod"
nickname    = "ec2instance"

tags = {
  environment      = "prod"
  nickname         = "ec2instance"
  application_name = "ec2-instance"
  application_desc = "Deploy Apache web server on EC2 Instance with the given instance type"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# key_name = "order-data-source"
