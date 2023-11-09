data "aws_partition" "current" {}

data "aws_iam_policy_document" "ec2_instance_role_assumed_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

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
