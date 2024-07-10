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

data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = [true]
  }
}

data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}


resource "aws_instance" "app_server" {
  ami             = data.aws_ami.this.id
  instance_type   = var.instance_type
  key_name        = var.key_name != "" ? var.key_name : null
  subnet_id       = data.aws_subnets.default.ids[0]
  security_groups = data.aws_security_groups.default.ids
  user_data       = file("init.sh")

  volume_tags = merge(var.tags, {
    Name = var.nickname
  })

  tags = merge(var.tags, {
    Name = var.nickname
  })
}
