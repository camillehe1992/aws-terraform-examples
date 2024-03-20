# General Deployment Variables
environment = "prod"
nickname    = "sg-rules"

tags = {
  environment      = "prod"
  nickname         = "sg-rules"
  application_name = "sg-rules"
  application_desc = "A template to assoicates a list of SG rules on an existing SG"
  emails           = "group@example.com"
  repo             = "https://github.com/camillehe1992/aws-terraform-examples"
}


# Project Specific Variables
ingress_prefix_lists = ["pl-67a5400e"]
ingress_cidrs = [{
  type = "cidr_ipv4",
  value = {
    cidr        = "172.31.0.0/16"
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
  }
  },
  {
    type = "cidr_ipv4",
    value = {
      cidr        = "172.31.0.0/16"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
    }
}]

egress_cidrs = [
  {
    type = "cidr_ipv4",
    value = {
      cidr        = "0.0.0.0/0"
      from_port   = null
      to_port     = null
      ip_protocol = "-1"
    }
  },
  {
    type = "cidr_ipv6",
    value = {
      cidr        = "::/0"
      from_port   = null
      to_port     = null
      ip_protocol = "-1"
    }
}]
