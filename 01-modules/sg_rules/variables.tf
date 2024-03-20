# General Deployment Variables
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

variable "security_group_id" {
  type        = string
  description = "The id of SG"

}
variable "ingress_prefix_lists" {
  type        = set(string)
  default     = []
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
  default     = []
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
  default     = []
  description = "A map of CIDR for egress"
}
