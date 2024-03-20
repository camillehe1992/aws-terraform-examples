data "aws_vpc" "main" {
  default = true
}

data "aws_ec2_managed_prefix_lists" "this" {
  filter {
    name   = "prefix-list-name"
    values = ["com.amazonaws.ap-southeast-1.s3"]
  }
}

data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}
