locals {
  prefix = "/${var.nickname}/${var.environment}/${data.aws_region.current.name}"
}
