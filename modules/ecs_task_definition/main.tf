# modules/ecs_task_definition/main.tf

resource "aws_ecs_task_definition" "this" {
  family                    = var.family_name
  requires_compatibilities  = ["FARGATE"]
  network_mode              = "awsvpc"
  cpu                       = var.cpu
  memory                    = var.memory
  task_role_arn             = var.task_role_arn
  execution_role_arn        = var.execution_role_arn

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  container_definitions = jsonencode(concat(
    [
      {
        name  = var.primary_container.name
        image = var.primary_container.image
        portMappings = [{
          containerPort = var.primary_container.container_port
          hostPort      = var.primary_container.host_port
          protocol      = "tcp"
          appProtocol   = "http"
        }]
        essential = true
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            "awslogs-group"         = "/ecs/${var.family_name}"
            "awslogs-region"        = var.log_region
            "awslogs-stream-prefix" = "ecs"
            "mode"                  = "non-blocking"
            "max-buffer-size"       = "25m"
            "awslogs-create-group"  = "true"
          }
        }
      }
    ],
    var.additional_containers != null ? [for container in var.additional_containers : {
      name  = container.name
      image = container.image
      portMappings = container.container_port != null ? [{
        containerPort = container.container_port
        hostPort      = container.host_port
        protocol      = "tcp"
      }] : []
      essential     = container.essential
      dockerLabels  = container.docker_labels
    }] : []
  ))

  tags = merge(
    {
      "functionality" = "Automation And Orchestration"
    },
    var.tags
  )
}