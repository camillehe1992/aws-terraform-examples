data "aws_partition" "current" {}

data "aws_iam_policy_document" "lambda_role_inline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = ["*"]
  }
}
