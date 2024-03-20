resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

module "security_group_rules" {
  source = "../01-modules/sg_rules"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  security_group_id = aws_security_group.allow_tls.id

  ingress_prefix_lists      = concat(data.aws_ec2_managed_prefix_lists.this.ids, var.ingress_prefix_lists)
  ingress_referenced_sg_ids = concat(data.aws_security_groups.default.ids, var.ingress_referenced_sg_ids)
  ingress_cidrs             = var.ingress_cidrs

  egress_referenced_sg_ids = []
  egress_cidrs             = var.egress_cidrs
}
