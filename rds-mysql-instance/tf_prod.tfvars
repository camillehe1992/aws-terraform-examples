# General Deployment Variables
env      = "prod"
nickname = "mysql"

tags = {
  environment      = "prod"
  nickname         = "mysql"
  application_name = "mysql-rds-database"
  application_desc = "Create a MYSQL RDS database with only one instance in AWS"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}

# Project Specific Variables
subnet_ids             = ["subnet-05caf66e740964d47", "subnet-0ac7236fe344b9a9c"]
vpc_security_group_ids = ["sg-0579f97438569f812"]
