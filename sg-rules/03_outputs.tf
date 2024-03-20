output "security_group_id" {
  value = aws_security_group.allow_tls.id
}

output "sg_rules" {
  value = {
    ingress = module.security_group.ingress
    egress  = module.security_group.egress
  }
}
