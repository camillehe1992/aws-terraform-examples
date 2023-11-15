data "aws_region" "current" {}
data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ecs_tasks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_tasks_role_inline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "firehose:PutRecordBatch",
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
    ]
    resources = ["*"]
  }
}
