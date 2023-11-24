# General Deployment Variables
env      = "dev"
nickname = "mysql"

tags = {
  environment      = "dev"
  nickname         = "mysql"
  application_name = "mysql-rds-database"
  application_desc = "Create a MYSQL RDS database with only one instance in AWS"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
subnet_ids             = ["subnet-04839c488f31e2829", "subnet-08122d3fc6e3ce9b1"]
vpc_security_group_ids = ["sg-00fe42c9972b4e4af"]
