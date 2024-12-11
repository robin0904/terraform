resource "aws_lb" "nlb" {
  name               = var.lb_name
  internal           = var.internal
  load_balancer_type = "network"
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = var.lb_name
  }
}

# Target Groups
resource "aws_lb_target_group" "target_groups" {
  for_each = var.target_groups

  name        = each.key
  port        = each.value.port
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = each.value.target_type

  health_check {
    enabled             = true
    protocol            = "TCP"
    port                = each.value.health_check_port != null ? each.value.health_check_port : each.value.port
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = each.key
  }
}

# Listeners
resource "aws_lb_listener" "listeners" {
  for_each = var.target_groups

  load_balancer_arn = aws_lb.nlb.arn
  port              = each.value.port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_groups[each.key].arn
  }
}