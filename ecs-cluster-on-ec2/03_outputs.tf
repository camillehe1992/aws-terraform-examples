output "ecs_cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "ecs_cluster_cloudwatch_logs_group_arn" {
  value = aws_cloudwatch_log_group.this.arn
}
