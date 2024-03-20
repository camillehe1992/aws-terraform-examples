# Ingress

# cidr_ipv4
resource "aws_vpc_security_group_ingress_rule" "allow_cidr_ipv4" {
  for_each = local.ingress_cidrs_ipv4

  security_group_id = var.security_group_id

  cidr_ipv4   = each.value.cidr
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port
}

# cidr_ipv6
resource "aws_vpc_security_group_ingress_rule" "allow_cidr_ipv6" {
  for_each = local.ingress_cidrs_ipv6

  security_group_id = var.security_group_id

  cidr_ipv4   = each.value.cidr
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port
}

# prefix_list_id
resource "aws_vpc_security_group_ingress_rule" "allow_prefix_lists" {
  for_each = var.ingress_prefix_lists

  security_group_id = var.security_group_id

  prefix_list_id = each.key
  ip_protocol    = "-1"
}

# referenced_security_group_id
resource "aws_vpc_security_group_ingress_rule" "allow_referenced_sgs" {
  for_each = var.ingress_referenced_sg_ids

  security_group_id = var.security_group_id

  referenced_security_group_id = each.key
  ip_protocol                  = "-1"
}

# Egress

# cidr_ipv4
resource "aws_vpc_security_group_egress_rule" "allow_cidr_ipv4" {
  for_each = local.egress_cidrs_ipv4

  security_group_id = var.security_group_id

  cidr_ipv4   = each.value.cidr
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port
}

# # cidr_ipv6
resource "aws_vpc_security_group_egress_rule" "allow_cidr_ipv6" {
  for_each = local.egress_cidrs_ipv6

  security_group_id = var.security_group_id

  cidr_ipv6   = each.value.cidr
  from_port   = each.value.from_port
  ip_protocol = each.value.ip_protocol
  to_port     = each.value.to_port
}
