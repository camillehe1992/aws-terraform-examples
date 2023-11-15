output "ecs_task_execution_role_arn" {
  value = module.ecs_task_execution_role.iam_role.arn
}

output "ecs_task_role_arn" {
  value = module.ecs_task_role.iam_role.arn
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.this.arn
}

output "aws_ecs_service" {
  value = {
    cluster = aws_ecs_service.this.cluster
    arn     = aws_ecs_service.this.id
  }
}

output "aws_lb_target_group" {
  value = aws_lb_target_group.this.arn
}

output "aws_lb_arn" {
  value = {
    domain_name = aws_lb.this.dns_name
    arn         = aws_lb.this.arn
  }
}
