resource "aws_ecs_service" "this" {
  name                              = "${var.env}-${var.nickname}"
  cluster                           = var.ecs_cluster_arn
  task_definition                   = aws_ecs_task_definition.this.arn
  desired_count                     = var.desired_count
  enable_ecs_managed_tags           = true
  health_check_grace_period_seconds = 60

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "${var.env}-${var.nickname}"
    container_port   = 80
  }

  force_new_deployment = true
  triggers = {
    redeployment = timestamp()
  }

  tags = var.tags
}
