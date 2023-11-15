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
