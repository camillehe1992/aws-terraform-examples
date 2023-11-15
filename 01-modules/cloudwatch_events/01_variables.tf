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

variable "rule_name" {
  type        = string
  description = "The EventBridge rule name"
}

variable "description" {
  type        = string
  description = "The description of EventBridge rule"
}

variable "schedule_expression" {
  type        = string
  description = "The schedule expression to trigger the target"
}

variable "is_enabled" {
  type        = bool
  default     = true
  description = "If enable the EventBridge rule"
}

variable "target_id" {
  type        = string
  description = "The target id of the EventBridge rule"
}

variable "target_arn" {
  type        = string
  description = "The target ARN of the EventBridge rule"
}
