module "ecs_task_execution_role" {
  source = "../01-modules/iam"

  tags                           = var.tags
  role_name                      = "${var.environment}-${var.nickname}-ecsTaskExecutionRole"
  role_description               = "The role grants the Amazon ECS container and Fargate agents permission to make AWS API calls on your behalf"
  assume_role_policy_identifiers = ["ecs-tasks.amazonaws.com"]
  aws_managed_policy_arns        = []
  customized_policies = {
    allow-cwlogs-ecr-policy = data.aws_iam_policy_document.ecs_tasks_execution_role_inline_policy.json
  }
  has_iam_instance_profile = false
}

module "ecs_task_role" {
  source = "../01-modules/iam"

  tags                           = var.tags
  role_name                      = "${var.environment}-${var.nickname}-ecsTaskRole"
  role_description               = "The role is used for container that running in ECS container instances to access other AWS services"
  assume_role_policy_identifiers = ["ecs-tasks.amazonaws.com"]
  aws_managed_policy_arns        = []
  customized_policies = {
    allow-secret-manager-readonly-policy = data.aws_iam_policy_document.ecs_tasks_role_inline_policy.json
  }
  has_iam_instance_profile = false
}
