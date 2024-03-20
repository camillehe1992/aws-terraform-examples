locals {
  # groupby type
  ingress_cidrs = {
    for item in var.ingress_cidrs : item.type => item.value...
  }
  ingress_cidrs_ipv4 = { for item in lookup(local.ingress_cidrs, "cidr_ipv4", {}) : index(local.ingress_cidrs.cidr_ipv4, item) => item }
  ingress_cidrs_ipv6 = { for item in lookup(local.ingress_cidrs, "cidr_ipv6", {}) : index(local.ingress_cidrs.cidr_ipv6, item) => item }
  # groupby type
  egress_cidrs = {
    for item in var.egress_cidrs : item.type => item.value...
  }
  egress_cidrs_ipv4 = { for item in lookup(local.egress_cidrs, "cidr_ipv4", {}) : index(local.egress_cidrs.cidr_ipv4, item) => item }
  egress_cidrs_ipv6 = { for item in lookup(local.egress_cidrs, "cidr_ipv6", {}) : index(local.egress_cidrs.cidr_ipv6, item) => item }
}
