data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = var.architecture
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.this.id
  instance_type = var.instance_type
  key_name      = var.key_name != "" ? var.key_name : null

  tags = merge(var.tags, {
    Name = var.nickname
  })
}
