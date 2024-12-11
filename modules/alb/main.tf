resource "aws_security_group" "alb_sg" {
  name        = "${var.lb_name}-sg"
  description = "Security group for ${var.lb_name}"
  vpc_id      = var.vpc_id

  # Inbound HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.lb_name}-sg"
  }
}

resource "aws_lb" "alb" {
  name               = var.lb_name
  internal           = var.internal
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.alb_sg.id]

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
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = each.value.target_type

  health_check {
    enabled             = true
    path                = each.value.health_check_path != null ? each.value.health_check_path : "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = each.key
  }
}

# Listeners
# HTTP Listener
resource "aws_lb_listener" "http_listener" {
  count             = var.http_listener_enabled ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = var.default_target_group != null ? "forward" : "redirect"

    dynamic "forward" {
      for_each = var.default_target_group != null ? [1] : []
      content {
        target_group {
          arn = aws_lb_target_group.target_groups[var.default_target_group].arn
        }
      }
    }

    dynamic "redirect" {
      for_each = var.default_target_group == null ? [1] : []
      content {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  count             = var.https_listener_enabled ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Page not found"
      status_code  = "404"
    }
  }
}

# Listener Rules
resource "aws_lb_listener_rule" "https_host_rules" {
  for_each = var.https_host_rules

  listener_arn = aws_lb_listener.https_listener[0].arn
  priority     = each.value.priority

  action {
    type             = each.value.action_type
    target_group_arn = each.value.action_type == "forward" ? aws_lb_target_group.target_groups[each.value.target_group].arn : null

    dynamic "redirect" {
      for_each = each.value.action_type == "redirect" ? [1] : []
      content {
        port        = each.value.redirect_port != null ? each.value.redirect_port : "443"
        protocol    = each.value.redirect_protocol != null ? each.value.redirect_protocol : "HTTPS"
        host        = each.value.redirect_host
        path        = "/#{path}"
        query       = "#{query}"
        status_code = each.value.redirect_status_code
      }
    }
  }

  condition {
    host_header {
      values = [each.key]
    }
  }
}