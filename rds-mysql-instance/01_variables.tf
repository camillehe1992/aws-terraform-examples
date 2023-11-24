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
variable "identifier" {
  type        = string
  default     = "my-demo-rds"
  description = "The identitier of RDS database"
}

variable "engine" {
  type        = string
  default     = "mysql"
  description = "The engine of RDS DB instance"
}

variable "engine_version" {
  type        = string
  default     = "8.0"
  description = "THe version of selected RDS DB engine"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "The instance class of RDS DB instance"
}

variable "username" {
  type        = string
  default     = "admin"
  description = "The username of RDS database"
}

variable "parameter_group_name" {
  type        = string
  default     = "default.mysql8.0"
  description = "The parameter group name"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet ids that RDS instance allocates"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group that RDS instance allocates"
}
