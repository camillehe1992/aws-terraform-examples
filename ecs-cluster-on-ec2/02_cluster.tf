# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/ecs_cluster
resource "aws_ecs_cluster" "this" {
  name = upper("${var.environment}-${var.ecs_cluster_name}")

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "this" {
  name              = aws_ecs_cluster.this.name
  retention_in_days = var.retention_in_days

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/autoscaling_group
resource "aws_autoscaling_group" "this" {
  name                      = upper("${var.environment}-${var.ecs_cluster_name}-asg")
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "ELB"
  desired_capacity          = var.asg_desired_size
  force_delete              = true
  launch_template {
    id = aws_launch_template.this.id
  }
  vpc_zone_identifier   = var.subnet_ids
  termination_policies  = ["OldestInstance"]
  protect_from_scale_in = false

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/autoscaling_lifecycle_hook
resource "aws_autoscaling_lifecycle_hook" "instance_terminating" {
  depends_on = [aws_sns_topic.this]

  name                   = "DrainingInstancesGracefully"
  autoscaling_group_name = aws_autoscaling_group.this.name
  default_result         = "ABANDON"
  heartbeat_timeout      = 900
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"

  notification_target_arn = aws_sns_topic.this.arn
  role_arn                = module.autoscaling_notification_role.iam_role.arn
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/ecs_capacity_provider
# Used to associate the auto-scaling group with the cluster’s capacity provider.
resource "aws_ecs_capacity_provider" "this" {
  name = upper("${var.environment}-${var.ecs_cluster_name}-capacity-provider")

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.this.arn
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/ecs_cluster_capacity_providers
# Used to bind the ASG capacity provider with the ECS cluster
resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = [aws_ecs_capacity_provider.this.name]
}
