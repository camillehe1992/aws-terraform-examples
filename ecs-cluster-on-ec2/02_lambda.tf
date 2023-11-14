module "scale_in_function" {
  source = "../01-modules/lambda"

  env      = var.env
  nickname = var.nickname
  tags     = var.tags

  function_name = "asg-scale-in"
  description   = "Gracefully scale in (terminate instances) from ECS ASG"
  role_arn      = module.instance_terminating_lambda_execution_role.iam_role.arn
  handler       = "asg-scale-in.lambda_handler"
  memory_size   = 128
  timeout       = 60
  runtime       = "python3.9"
  source_file   = "asg-scale-in.py"
  output_path   = "asg-scale-in.zip"

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
