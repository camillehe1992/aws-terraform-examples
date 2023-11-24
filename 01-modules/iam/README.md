# Terraform Module Details

## Variables

| Variable Name                  | Type         | Description                                                      | Default                  |
| ------------------------------ | ------------ | ---------------------------------------------------------------- | ------------------------ |
| tags                           | map(string)  | The key value pairs apply as tags to all resources in the module | {}                       |
| name_prefix                    | string       | The prefix of the IAM role name                                  | empty string             |
| role_name                      | string       | The name of IAM role                                             | LambdaExecutionRole      |
| role_description               | string       | The description of IAM role                                      | empty string             |
| assume_role_policy_identifiers | list(string) | The AWS service identitifers that are allowed to assume the role | ["lambda.amazonaws.com"] |
| aws_managed_policy_arns        | set(string)  | A set of AWS managed policy ARN                                  | []                       |
| customized_policies            | map(string)  | A map of JSON format of IAM policy                               | {}                       |
| has_iam_instance_profile       | boolean      | If to create instance profile for the role                       | false                    | - |

## Example Usage

### Basic Usage

```bash
module "lambda_execution_role" {
  source = "../01-modules/iam"

  name_prefix             = "dev-"
  aws_managed_policy_arns = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
```

### IAM Role with Customized Configuration

```bash
data "aws_iam_policy_document" "ecs_tasks_execution_role_inline_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]
    resources = ["*"]
  }
}

module "lambda_execution_role" {
  source = "../01-modules/iam"

  tags = {
    environment = "dev"
    nickname    = "pokemon"
  }

  name_prefix             = "dev-"
  role_name                   = "ecsTaskExecutionRole"
  role_description            = "The task execution role grants the Amazon ECS container and Fargate agents permission to make AWS API calls on your behalf."
  assume_role_policy_identifiers = ["ecs-tasks.amazonaws.com"]
  aws_managed_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  ]
  customized_policies = {
    allow-cwlogs-ecr-policy = data.aws_iam_policy_document.ecs_tasks_execution_role_inline_policy.json
  }
  has_iam_instance_profile = true
}
```

## Outputs

```bash
output "iam_role" {
  value = {
    arn  = aws_iam_role.this.arn
    id   = aws_iam_role.this.id
    name = aws_iam_role.this.name
  }
}
```