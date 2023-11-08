# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/ecs_task_definition
resource "aws_ecs_task_definition" "this" {
  family = "${var.env}-${var.nickname}"
  container_definitions = jsonencode([
    {
      name               = "${var.env}-${var.nickname}"
      image              = var.image
      cpu                = 10
      memory             = 512
      execution_role_arn = module.ecs_task_execution_role.iam_role.arn
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      mountPoints = [
        {
          sourceVolume  = "my-vol",
          containerPath = "/var/www/my-vol"
        }
      ]
      entryPoint = ["/usr/sbin/apache2", "-D", "FOREGROUND"]
      essential  = true
    },
    {
      name   = "busybox"
      image  = "busybox"
      cpu    = 10
      memory = 256
      volumeFrom = {
        sourceContainer = "${var.env}-${var.nickname}"
      }
      entryPoint = ["sh", "-c"]
      command    = ["/bin/sh -c \"while true; do /bin/date > /var/www/my-vol/date; sleep 1; done\""]
      essential  = false
    }
  ])

  volume {
    name      = "my-vol"
    host_path = "/ecs/service-storage"
  }
}
