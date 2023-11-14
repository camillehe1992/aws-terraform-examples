# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/lambda_function
resource "aws_lambda_function" "drain_ecs_tasks" {
  function_name    = "${var.env}-${var.nickname}-drain-ecs-tasks"
  description      = "Gracefully drain ECS tasks from EC2 instances before the instances are terminated by autoscaling."
  role             = module.instance_terminating_lambda_execution_role.iam_role.arn
  handler          = "drain-ecs-tasks.lambda_handler"
  memory_size      = 128
  runtime          = "python3.9"
  timeout          = 60
  filename         = "drain-ecs-tasks.zip"
  source_code_hash = data.archive_file.drain_ecs_tasks.output_base64sha256

  environment {
    variables = {
      CLUSTER = aws_ecs_cluster.this.arn
    }
  }

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "instance_terminating" {
  name              = "/aws/lambda/${var.env}-${var.nickname}-drain-ecs-tasks"
  retention_in_days = var.retention_in_days
  tags              = var.tags
}


# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/lambda_permission
resource "aws_lambda_permission" "instance_terminating" {
  statement_id  = "AllowExecutionSNSTopic"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.drain_ecs_tasks.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.this.arn
}
