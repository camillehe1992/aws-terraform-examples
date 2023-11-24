data "aws_partition" "current" {}

data "aws_iam_policy_document" "allow_autoscaling_policy" {
  statement {
    effect = "Allow"
    actions = [
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:CompleteLifecycleAction",
      "autoscaling:DescribeLifecycleHooks"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "allow_container_instances_update_policy" {
  statement {
    effect = "Allow"
    actions = [
      "autoscaling:CompleteLifecycleAction",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ecs:ListContainerInstances",
      "ecs:DescribeContainerInstances",
      "ecs:UpdateContainerInstancesState",
      "sns:Publish"
    ]
    resources = ["*"]
  }
}
