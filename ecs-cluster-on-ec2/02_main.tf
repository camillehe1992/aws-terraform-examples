resource "aws_ecs_cluster" "this" {
  name = upper("${var.env}-${var.ecs_cluster_name}")

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}

resource "aws_launch_configuration" "this" {
  name_prefix   = upper("${var.env}-${var.ecs_cluster_name}-")
  image_id      = var.image_id
  instance_type = var.instance_type

  lifecycle {
    create_before_destroy = true
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/autoscaling_group
resource "aws_autoscaling_group" "this" {
  name                      = upper("${var.env}-${var.ecs_cluster_name}-asg")
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "ELB"
  desired_capacity          = var.asg_desired_size
  force_delete              = true
  launch_configuration      = aws_launch_configuration.this.name
  vpc_zone_identifier       = var.subnet_ids
  termination_policies      = ["OldestInstance"]
  protect_from_scale_in     = false

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

resource "aws_ecs_capacity_provider" "this" {
  name = upper("${var.env}-${var.ecs_cluster_name}-capacity-provider")

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.this.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 10
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 10
    }
  }
}
