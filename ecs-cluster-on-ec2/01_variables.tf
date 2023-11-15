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
variable "ecs_cluster_name" {
  type        = string
  description = "Name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
}

variable "image_id" {
  type        = string
  description = "The AMI Id that is used to launch EC2 instances"
}

variable "instance_type" {
  type = string
  validation {
    condition     = substr(var.instance_type, 0, 3) == "t4g"
    error_message = "The instance_type value must be a valid instance type, starting with \"t4g\"."
  }
  description = "The EC2 instance type running in ECS, allowed instance familly t4g."
}

variable "asg_max_size" {
  type        = number
  default     = 3
  description = "The max count of EC2 instances in ASG"
}

variable "asg_min_size" {
  type        = number
  default     = 0
  description = "The min count of EC2 instances in ASG"
}

variable "asg_desired_size" {
  type        = number
  default     = 0
  description = "The desired count of EC2 instances in ASG"
}

variable "health_check_grace_period" {
  type        = number
  default     = 60
  description = "The grace period in seconds for health check"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnets for EC2 instances in ASG"
}

variable "security_group" {
  type        = string
  description = "The security group names to associate with for EC2 instances"
}

variable "retention_in_days" {
  type        = number
  default     = 60
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0."
}
