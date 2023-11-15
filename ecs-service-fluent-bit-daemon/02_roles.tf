module "ecs_task_role" {
  source = "../01-modules/iam"

  tags                        = var.tags
  role_name                   = "${var.env}-${var.nickname}-ecsTaskRole"
  role_description            = "This IAM Role grants the task access to firehose and CloudWatch Logs"
  assume_role_policy_document = data.aws_iam_policy_document.ecs_tasks_assume_role_policy.json
  aws_managed_policy_arns     = []
  customized_policies = {
    allow-secret-manager-readonly-policy = data.aws_iam_policy_document.ecs_tasks_role_inline_policy.json
  }
}

module "firehose_delivery_role" {
  source = "../01-modules/iam"

  tags                        = var.tags
  role_name                   = "${var.env}-${var.nickname}-firehoseDeliveryRole"
  role_description            = "This IAM Role grants Firehose to write to S3"
  assume_role_policy_document = data.aws_iam_policy_document.firehose_assume_role_policy.json
  aws_managed_policy_arns     = []
  customized_policies = {
    allow-firehose-fluentbit-s3-streaming-policy = data.aws_iam_policy_document.firehose_delivery_role_inline_policy.json
  }
}
