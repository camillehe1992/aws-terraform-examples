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

variable "function_name" {
  type        = string
  description = "The name of Lambda function"
  default     = "hello-world"
}
variable "runtime" {
  type        = string
  description = "The runtime of Lambda function"
  default     = "python3.9"
}

variable "retention_in_days" {
  type        = number
  description = "The rentention time of CloudWatch Logs group in days"
  default     = 7
}

# API Gateway
variable "openapi_json_file" {
  type        = string
  description = "The path of OpenAPI specification of API Gateway Rest API"
  default     = "swagger.yaml"
}

variable "stage_name" {
  type        = string
  default     = "v1"
  description = "The stage name of API Gateway Rest API"
}

variable "rest_api_name" {
  type        = string
  default     = "hello-world"
  description = "The name of API Gateway Rest API"
}

variable "api_gateway_log_retention_days" {
  type        = number
  default     = 7
  description = <<EOF
    Specifies the number of days you want to retain log events in the specific api gateway log group.
    Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653
  EOF
}
