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
    container_port   = 80
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
          containerPort = 80
          hostPort      = 8080
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
      healthCheck = {
        command = ["CMD-SHELL", "curl -f http://localhost/health || exit 1"]
      }
    }
  ])

  tags = var.tags
}
