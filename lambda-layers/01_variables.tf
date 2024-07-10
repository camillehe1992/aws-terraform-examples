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
variable "s3_bucket" {
  type        = string
  default     = ""
  description = "S3 bucket location containing the function's deployment package. Conflicts with filename"
}

variable "runtimes" {
  type        = list(string)
  description = "List of compatible runtimes of the Lambda layer, e.g. [python3.10]"
  default     = ["python3.10", "python3.11", "python3.12"]
}

variable "architecture" {
  type    = string
  default = "x86_64"
  validation {
    condition     = contains(["arm64", "x86_64"], var.architecture)
    error_message = "The architecture value must be arm64 or x86_64"
  }
  description = "The type of computer processor that Lambda uses to run the function"
}
