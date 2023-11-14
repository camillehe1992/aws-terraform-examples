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

data "aws_iam_policy_document" "autoscalling_notification_role_assumed_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["autoscaling.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_assumed_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
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

data "archive_file" "drain_ecs_tasks" {
  type        = "zip"
  source_file = "drain-ecs-tasks.py"
  output_path = "drain-ecs-tasks.zip"
}
