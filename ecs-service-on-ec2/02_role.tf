module "ecs_task_execution_role" {
  source = "../01-modules/iam"

  env      = var.env
  nickname = var.nickname
  tags     = var.tags

  role_name                   = "ecsTaskExecutionRole"
  role_description            = "The task execution role grants the Amazon ECS container and Fargate agents permission to make AWS API calls on your behalf."
  assume_role_policy_document = data.aws_iam_policy_document.ecs_tasks_assume_role_policy.json
  aws_managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  ]
  customized_policies      = {}
  has_iam_instance_profile = false
}
