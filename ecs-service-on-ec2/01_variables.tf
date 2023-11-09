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

variable "env" {
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
variable "vpc_id" {
  type        = string
  description = "The VPC id for load balancer target group, which is the EC2 instances locate"
}
variable "ecs_cluster_arn" {
  type        = string
  description = "The ARN of ECS Cluster"
}

variable "desired_count" {
  type        = number
  description = "Number of instances of the task definition to place and keep running. Defaults to 0"
}

variable "image" {
  type        = string
  description = "The image used to start a container"
}

variable "security_groups" {
  type        = list(string)
  description = "The secuirty group ids for ALB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet ids for ALB"
}