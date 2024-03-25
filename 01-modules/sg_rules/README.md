# Module Overview

The detailed information about the module.

## Providers

| Name | Version |
| ---- | ------- |
| aws  | 5.41.0  |

The module automatically inherits default provider configurations from its parent.

## Resources

| Name                                                                                                                                                                    | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_vpc_security_group_egress_rule.allow_cidr_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule)        | resource |
| [aws_vpc_security_group_egress_rule.allow_cidr_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule)        | resource |
| [aws_vpc_security_group_ingress_rule.allow_cidr_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule)      | resource |
| [aws_vpc_security_group_ingress_rule.allow_cidr_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule)      | resource |
| [aws_vpc_security_group_ingress_rule.allow_prefix_lists](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule)   | resource |
| [aws_vpc_security_group_ingress_rule.allow_referenced_sgs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name                         | Description                                                                            | Type                                                                                                                            | Default | Required |
| ---------------------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| egress\_cidrs                | A map of CIDR for egress                                                               | ```set(object({ type = string value = object({ cidr = string from_port = number to_port = number ip_protocol = string }) }))``` | `[]`    |    no    |
| egress\_referenced\_sg\_ids  | A set of referenced SG ids for egress                                                  | `set(string)`                                                                                                                   | `[]`    |    no    |
| environment                  | The environment of application                                                         | `string`                                                                                                                        | n/a     |   yes    |
| ingress\_cidrs               | A map of CIDR for ingress                                                              | ```set(object({ type = string value = object({ cidr = string from_port = number to_port = number ip_protocol = string }) }))``` | `[]`    |    no    |
| ingress\_prefix\_lists       | A set of prefix list for com.amazonaws.ap-southeast-1.dynamodb                         | `set(string)`                                                                                                                   | `[]`    |    no    |
| ingress\_referenced\_sg\_ids | A set of referenced SG id for ingress                                                  | `set(string)`                                                                                                                   | `[]`    |    no    |
| nickname                     | The nickname of application. Must be lowercase without special chars                   | `string`                                                                                                                        | n/a     |   yes    |
| security\_group\_id          | The id of SG                                                                           | `string`                                                                                                                        | n/a     |   yes    |
| tags                         | The key value pairs we want to apply as tags to the resources contained in this module | `map(string)`                                                                                                                   | n/a     |   yes    |

## Outputs

| Name    | Description |
| ------- | ----------- |
| egress  | n/a         |
| ingress | n/a         |
