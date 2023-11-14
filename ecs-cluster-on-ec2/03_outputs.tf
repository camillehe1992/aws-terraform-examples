output "ecs_cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "ecs_cluster_cloudwatch_logs_group_arn" {
  value = aws_cloudwatch_log_group.this.arn
}

output "ec2_instance_role_arn" {
  value = module.ec2_instance_role.iam_role.arn
}

output "autoscaling_notification_role_arn" {
  value = module.autoscaling_notification_role.iam_role.arn
}

output "instance_terminating_lambda_execution_role_arn" {
  value = module.instance_terminating_lambda_execution_role.iam_role.arn
}

output "trigger_lambda_sns_topic_arn" {
  value = aws_sns_topic.this.arn
}

output "asg_lambda_arn" {
  value = aws_lambda_function.drain_ecs_tasks.arn
}
