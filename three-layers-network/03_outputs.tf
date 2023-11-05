# Ouputs
output "vpc_id" {
  value = aws_vpc.this.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "subnet_ids" {
  value = {
    private = [for subnet in aws_subnet.private : subnet.id],
    public  = [for subnet in aws_subnet.public : subnet.id]
  }
}

output "security_group_elb_id" {
  value = aws_security_group.elb.id
}

output "security_group_app_id" {
  value = aws_security_group.app.id
}

output "security_group_data_id" {
  value = aws_security_group.data.id
}
