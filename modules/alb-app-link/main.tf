resource "aws_lb_target_group" "this" {
  for_each = var.rules

  name        = "${var.app_name}-${each.key}-${var.environment}"
  port        = each.value.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 30
    path                = each.value.health_check_path
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = merge(var.tags, {
    Name = "${var.app_name}-${each.key}-${var.environment}"
  })
}

resource "aws_lb_listener_rule" "this" {
  for_each = var.rules

  listener_arn = var.listener_arn
  priority     = each.value.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }

  condition {
    host_header {
      values = [each.value.host_header]
    }
  }
}
