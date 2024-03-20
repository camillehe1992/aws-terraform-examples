resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

module "security_group" {
  source = "../01-modules/sg_rules"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  security_group_id = aws_security_group.allow_tls.id

  ingress_prefix_lists = concat(data.aws_ec2_managed_prefix_lists.this.ids, [
    "pl-67a5400e",
  ])

  ingress_referenced_sg_ids = concat(data.aws_security_groups.default.ids, [])

  ingress_cidrs = [
    {
      type = "cidr_ipv4",
      value = {
        cidr        = "172.31.0.0/16"
        from_port   = 443
        to_port     = 443
        ip_protocol = "tcp"
      }
    },
    {
      type = "cidr_ipv4",
      value = {
        cidr        = "172.31.0.0/16"
        from_port   = 80
        to_port     = 80
        ip_protocol = "tcp"
      }
    }
  ]

  egress_referenced_sg_ids = []

  egress_cidrs = [
    {
      type = "cidr_ipv4",
      value = {
        cidr        = "0.0.0.0/0"
        from_port   = null
        to_port     = null
        ip_protocol = "-1"
      }
    },
    {
      type = "cidr_ipv6",
      value = {
        cidr        = "::/0"
        from_port   = null
        to_port     = null
        ip_protocol = "-1"
      }
  }]
}
