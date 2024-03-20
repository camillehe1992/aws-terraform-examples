output "ingress" {
  value = {
    allow_cidr_ipv4      = aws_vpc_security_group_ingress_rule.allow_cidr_ipv4
    allow_cidr_ipv6      = aws_vpc_security_group_ingress_rule.allow_cidr_ipv6
    allow_prefix_lists   = aws_vpc_security_group_ingress_rule.allow_prefix_lists
    allow_referenced_sgs = aws_vpc_security_group_ingress_rule.allow_referenced_sgs
  }
}

output "egress" {
  value = {
    allow_cidr_ipv4 = aws_vpc_security_group_egress_rule.allow_cidr_ipv4
    allow_cidr_ipv6 = aws_vpc_security_group_egress_rule.allow_cidr_ipv6
  }
}
