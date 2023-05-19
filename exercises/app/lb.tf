resource "aws_lb_target_group" "this" {
  for_each    = local.applications
  name        = "${local.handle}-${each.key}"
  port        =  each.value.port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
  }
}

resource "aws_lb_listener_rule" "this" {
  for_each     = local.applications
  listener_arn = local.arn_listener
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }

  condition {
    host_header {
      values = ["${local.handle}-${each.key}.${local.zone_name}"]
    }
  }

  lifecycle {
    ignore_changes = [
      priority
    ]
  }
}
