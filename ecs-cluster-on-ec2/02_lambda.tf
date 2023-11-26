module "ecs_container_draining_function" {
  source = "../01-modules/lambda"

  environment = var.environment
  nickname    = var.nickname
  tags        = var.tags

  function_name = "ecs-container-draining"
  description   = "Gracefully drain ECS tasks from EC2 instances before the instances are terminated by autoscaling."
  role_arn      = module.instance_terminating_lambda_execution_role.iam_role.arn
  handler       = "ecs-container-draining.lambda_handler"
  memory_size   = 128
  timeout       = 60
  runtime       = "python3.9"
  source_file   = "ecs-container-draining.py"
  output_path   = "ecs-container-draining.zip"

  layers = []
  environment_variables = {
    ECS_CLUSTER_ARN = aws_ecs_cluster.this.arn
  }
  subnet_ids         = []
  security_group_ids = []

  lambda_permissions = {
    allow-execution-sns-topic = {
      principal  = "sns.amazonaws.com"
      source_arn = aws_sns_topic.this.arn
    }
  }
}
