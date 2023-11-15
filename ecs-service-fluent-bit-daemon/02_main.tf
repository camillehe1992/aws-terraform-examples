# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/ecs_service
resource "aws_ecs_service" "this" {
  name                 = "${var.env}-${var.nickname}"
  cluster              = local.ecs_cluster_arn
  task_definition      = aws_ecs_task_definition.this.arn
  force_new_deployment = true
  scheduling_strategy  = "DAEMON"

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/ecs_task_definition
resource "aws_ecs_task_definition" "this" {
  family        = "${var.env}-${var.nickname}"
  task_role_arn = module.ecs_task_role.iam_role.arn
  container_definitions = jsonencode([
    {
      name              = "${var.env}-${var.nickname}-daemon"
      image             = var.image
      memoryReservation = var.memory

      mountPoints = [
        {
          containerPath = "/var/run"
          sourceVolume  = "socket"
        }
      ]

      environment = [
        {
          name  = "FLB_LOG_LEVEL"
          value = "INFO"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-region        = data.aws_region.current.name,
          awslogs-group         = "${var.env}-app-ecs-cluster"
          awslogs-stream-prefix = var.nickname
        }
      }
      essential = true
    }
  ])

  volume {
    name      = "socket"
    host_path = "/var/run"
  }

  tags = var.tags
}
