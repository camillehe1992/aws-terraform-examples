module "ec2_instance_role" {
  source = "../01-modules/iam"

  tags                        = var.tags
  role_name                   = "ecsInstanceRole"
  role_description            = "The IAM role that attached in ECS container instances"
  assume_role_policy_document = data.aws_iam_policy_document.ec2_instance_role_assumed_policy.json
  aws_managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
  ]
  customized_policies = {
    allow-autoscaling-policy = data.aws_iam_policy_document.allow_autoscaling_policy.json
  }
  has_iam_instance_profile = true
}

module "autoscaling_notification_role" {
  source = "../01-modules/iam"

  tags                        = var.tags
  role_name                   = "autoscalingNotificationRole"
  role_description            = "The IAM role that attached in ECS container instances"
  assume_role_policy_document = data.aws_iam_policy_document.autoscalling_notification_role_assumed_policy.json
  aws_managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AutoScalingNotificationAccessRole",
  ]
  customized_policies = {}
}

module "instance_terminating_lambda_execution_role" {
  source = "../01-modules/iam"

  tags                        = var.tags
  role_name                   = "ecsInstanceTerminatingLambdaExecutionRole"
  role_description            = "The IAM role that grants lambda function permissions to terminate instances in ASG"
  assume_role_policy_document = data.aws_iam_policy_document.lambda_assumed_policy.json
  aws_managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AutoScalingNotificationAccessRole",
  ]
  customized_policies = {
    allow-autoscaling-policy = data.aws_iam_policy_document.allow_container_instances_update_policy.json
  }
}

