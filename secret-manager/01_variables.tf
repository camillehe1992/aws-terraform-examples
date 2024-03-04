# General Deployment Variables
variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_profile" {
  type        = string
  default     = null
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

# SecretManager Secrets
# SECRETS ARE RETRIEVED FROM GITHUBS ACTIONS SECRETS. NEVER EVER SET A VALUE FOR SECRET HERE
# https://developer.hashicorp.com/terraform/cli/config/environment-variables#tf_var_name
variable "database_password" {
  type        = string
  description = "The password of database"
}
