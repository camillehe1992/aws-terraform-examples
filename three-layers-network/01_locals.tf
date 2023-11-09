locals {
  private_subnet_cidrs = { for cidr in var.private_subnet_cidrs : index(var.private_subnet_cidrs, cidr) => cidr }
  public_subnet_cidrs  = { for cidr in var.public_subnet_cidrs : index(var.public_subnet_cidrs, cidr) => cidr }
}
