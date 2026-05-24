resource "aws_lb" "this" {
  count = var.create ? 1 : 0

  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  idle_timeout               = var.idle_timeout
  enable_deletion_protection = var.enable_deletion_protection

  dynamic "access_logs" {
    for_each = var.access_logs_enabled ? [1] : []
    content {
      bucket  = var.access_logs_bucket
      prefix  = var.access_logs_prefix
      enabled = true
    }
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_lb_target_group" "this" {
  for_each = { for tg in var.target_groups : tg.name => tg if var.create }

  name        = each.value.name
  port        = lookup(each.value, "port", null)
  protocol    = lookup(each.value, "protocol", null)
  vpc_id      = var.vpc_id
  target_type = lookup(each.value, "target_type", "instance")

  deregistration_delay = lookup(each.value, "deregistration_delay", 300)

  dynamic "health_check" {
    for_each = [lookup(each.value, "health_check", {})]
    content {
      enabled             = lookup(health_check.value, "enabled", true)
      interval            = lookup(health_check.value, "interval", 30)
      path                = lookup(health_check.value, "path", "/")
      port                = lookup(health_check.value, "port", "traffic-port")
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", 3)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", 3)
      timeout             = lookup(health_check.value, "timeout", 5)
      protocol            = lookup(health_check.value, "protocol", "HTTP")
      matcher             = lookup(health_check.value, "matcher", "200")
    }
  }

  dynamic "stickiness" {
    for_each = [lookup(each.value, "stickiness", {})]
    content {
      enabled         = lookup(stickiness.value, "enabled", false)
      type            = lookup(stickiness.value, "type", "lb_cookie")
      cookie_duration = lookup(stickiness.value, "cookie_duration", 86400)
    }
  }

  tags = merge(var.tags, lookup(each.value, "tags", {}))

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "http" {
  for_each = { for l in var.http_tcp_listeners : l.port => l if var.create }

  load_balancer_arn = aws_lb.this[0].arn
  port              = each.value.port
  protocol          = "HTTP"

  dynamic "default_action" {
    for_each = [lookup(each.value, "default_action", {
      type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Not Found"
        status_code  = "404"
      }
    })]
    content {
      type             = default_action.value.type
      target_group_arn = lookup(default_action.value, "target_group_arn", null) == null && default_action.value.type == "forward" ? aws_lb_target_group.this[default_action.value.target_group_name].arn : lookup(default_action.value, "target_group_arn", null)

      dynamic "redirect" {
        for_each = lookup(default_action.value, "redirect", null) != null ? [default_action.value.redirect] : []
        content {
          port        = lookup(redirect.value, "port", null)
          protocol    = lookup(redirect.value, "protocol", null)
          status_code = lookup(redirect.value, "status_code", "HTTP_301")
          host        = lookup(redirect.value, "host", "#{host}")
          path        = lookup(redirect.value, "path", "/#{path}")
          query       = lookup(redirect.value, "query", "#{query}")
        }
      }

      dynamic "fixed_response" {
        for_each = lookup(default_action.value, "fixed_response", null) != null ? [default_action.value.fixed_response] : []
        content {
          content_type = fixed_response.value.content_type
          message_body = lookup(fixed_response.value, "message_body", null)
          status_code  = lookup(fixed_response.value, "status_code", null)
        }
      }
    }
  }
}

resource "aws_lb_listener" "https" {
  for_each = { for l in var.https_listeners : l.port => l if var.create }

  load_balancer_arn = aws_lb.this[0].arn
  port              = each.value.port
  protocol          = "HTTPS"
  ssl_policy        = lookup(each.value, "ssl_policy", "ELBSecurityPolicy-2016-08")
  certificate_arn   = each.value.certificate_arn

  dynamic "default_action" {
    for_each = [lookup(each.value, "default_action", {
      type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Not Found"
        status_code  = "404"
      }
    })]
    content {
      type             = default_action.value.type
      target_group_arn = lookup(default_action.value, "target_group_arn", null) == null && default_action.value.type == "forward" ? aws_lb_target_group.this[default_action.value.target_group_name].arn : lookup(default_action.value, "target_group_arn", null)

      dynamic "fixed_response" {
        for_each = lookup(default_action.value, "fixed_response", null) != null ? [default_action.value.fixed_response] : []
        content {
          content_type = fixed_response.value.content_type
          message_body = lookup(fixed_response.value, "message_body", null)
          status_code  = lookup(fixed_response.value, "status_code", null)
        }
      }
    }
  }
}

resource "aws_wafv2_web_acl_association" "this" {
  count = var.create && var.waf_web_acl_arn != null ? 1 : 0

  resource_arn = aws_lb.this[0].arn
  web_acl_arn  = var.waf_web_acl_arn
}
