# Create ECS services dynamically
resource "aws_ecs_service" "this" {
  for_each = toset(var.service_names)

  name            = each.key
  cluster         = var.cluster_name
  task_definition = var.task_definition_arns[each.key]
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn[each.key]
    container_name   = each.key
    container_port   = var.container_ports[each.value]
  }

  tags = {
    Name = each.key
  }
}