resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

  tags = merge(
    {
      Name = var.cluster_name
    },
    var.tags
  )
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  count = length(var.capacity_providers) > 0 ? 1 : 0

  cluster_name      = aws_ecs_cluster.this.name
  capacity_providers = var.capacity_providers

  dynamic "default_capacity_provider_strategy" {
    for_each = var.capacity_providers

    content {
      capacity_provider = default_capacity_provider_strategy.value
      base = default_capacity_provider_strategy.value == "FARGATE" ? lookup(
        var.default_capacity_strategy[count.index],
        "base",
        1
      ) : null
      weight = lookup(
        var.default_capacity_strategy[count.index],
        "weight",
        100
      )
    }
  }
}
