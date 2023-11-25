output "instance" {
  description = "The output of EC2 instance"
  value = {
    instance_id        = aws_instance.app_server.id
    instance_public_ip = aws_instance.app_server.public_ip
  }
}
