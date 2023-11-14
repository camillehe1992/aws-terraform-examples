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
variable "ecs_cluster_name" {
  type        = string
  description = "The ARN of ECS Cluster"
}

variable "image" {
  type        = string
  description = "The image used to start a container"
}

variable "security_groups" {
  type        = list(string)
  description = "The secuirty group ids for ALB"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "The subnet ids for ALB"
}

variable "health_check_grace_period_seconds" {
  type        = number
  default     = 60
  description = "The grace period seconds before checking container health status"
}

variable "desired_count" {
  type        = number
  default     = 0
  description = "Number of instances of the task definition to place and keep running"
}

variable "min_capacity" {
  type        = number
  default     = 0
  description = "Min capacity of the scalable target"
}

variable "max_capacity" {
  type        = number
  default     = 10
  description = "Max capacity of the scalable target"
}

variable "cpu_utilization_target_value" {
  type        = number
  default     = 75
  description = "The target percentage of the ECS service CPU utilization"
}

variable "cpu" {
  type        = number
  default     = 128
  description = "The allocated CPU size"
}

variable "memory" {
  type        = number
  default     = 128
  description = "The allocated memory size"
}

variable "health_check" {
  type        = string
  default     = "/health"
  description = "The path of health check for container"
}

variable "container_port" {
  type        = number
  description = "The port of the container"
}
