# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/launch_template
resource "aws_launch_template" "this" {
  name_prefix   = "${var.environment}-${var.ecs_cluster_name}-"
  image_id      = var.image_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.security_group]

  iam_instance_profile {
    name = module.ec2_instance_role.iam_role.name
  }

  instance_market_options {
    market_type = "spot"
  }

  monitoring {
    enabled = true
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${aws_ecs_cluster.this.name}-container-instance"
    }
  }

  update_default_version = true

  user_data = base64encode(templatefile("${path.module}/ecs.sh", { ECS_CLUSTER = upper("${var.environment}-${var.ecs_cluster_name}") }))

  tags = var.tags
}
