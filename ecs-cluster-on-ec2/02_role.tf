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
