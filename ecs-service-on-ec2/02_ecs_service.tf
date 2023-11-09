# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/ecs_service
resource "aws_ecs_service" "this" {
  name                              = "${var.env}-${var.nickname}"
  cluster                           = var.ecs_cluster_arn
  task_definition                   = aws_ecs_task_definition.this.arn
  desired_count                     = var.desired_count
  enable_ecs_managed_tags           = true
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "${var.env}-${var.nickname}"
    container_port   = 5000
  }

  force_new_deployment = true
  # triggers = {
  #   redeployment = timestamp()
  # }

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/ecs_task_definition
resource "aws_ecs_task_definition" "this" {
  family = "${var.env}-${var.nickname}"
  container_definitions = jsonencode([
    {
      name               = "${var.env}-${var.nickname}"
      image              = var.image
      cpu                = var.cpu
      memory             = var.memory
      execution_role_arn = module.ecs_task_execution_role.iam_role.arn
      portMappings = [
        {
          containerPort = 5000
        }
      ]
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-create-group  = "true",
          awslogs-region        = data.aws_region.current.name,
          awslogs-group         = "ecs-services-logs"
          awslogs-stream-prefix = "${var.env}-${var.nickname}"
        }
      }
      essential = true
    }
  ])

  volume {
    name      = "my-vol"
    host_path = "/ecs/service-storage"
  }

  tags = var.tags
}
