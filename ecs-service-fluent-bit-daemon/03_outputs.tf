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

output "firehose_delivery_role_arn" {
  value = module.firehose_delivery_role.iam_role.arn
}

output "firehose_delivery_stream_arn" {
  value = aws_kinesis_firehose_delivery_stream.this.arn
}
