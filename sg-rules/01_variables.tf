# General Deployment Variables
variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_profile" {
  type        = string
  default     = "default"
  description = "AWS profile which used for terraform infra deployment"
}

variable "environment" {
  type        = string
  description = "The environment of application"
}

variable "nickname" {
  type        = string
  description = "The nickname of application. Must be lowercase without special chars"
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}

# Project Specific Variables
variable "ingress_prefix_lists" {
  type = set(string)
  default = [
    "pl-67a5400e"
  ]
  description = "A set of prefix list for com.amazonaws.ap-southeast-1.dynamodb"
}

variable "ingress_referenced_sg_ids" {
  type        = set(string)
  default     = []
  description = "A set of referenced SG id for ingress"
}

variable "ingress_cidrs" {
  type = set(object({
    type = string
    value = object({
      cidr        = string
      from_port   = number
      to_port     = number
      ip_protocol = string
    })
  }))
  default = [
    {
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
    }
  ]
  description = "A map of CIDR for ingress"
}

variable "egress_referenced_sg_ids" {
  type        = set(string)
  default     = []
  description = "A set of referenced SG ids for egress"
}

variable "egress_cidrs" {
  type = set(object({
    type = string
    value = object({
      cidr        = string
      from_port   = number
      to_port     = number
      ip_protocol = string
    })
  }))
  default = [
    {
      type = "cidr_ipv4",
      value = {
        cidr        = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
        ip_protocol = "-1"
      }
    },
    {
      type = "cidr_ipv6",
      value = {
        cidr        = "::/0"
        from_port   = 0
        to_port     = 0
        ip_protocol = "-1"
      }
  }]
  description = "A map of CIDR for egress"
}
