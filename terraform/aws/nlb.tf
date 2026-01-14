# Network Load Balancer for Databricks Serverless → dbx-proxy
resource "aws_lb" "this" {
  name               = "${local.prefix}-nlb"
  load_balancer_type = "network"
  internal           = true
  subnets            = local.subnet_ids

  enable_deletion_protection = false

  tags = local.tags
}

# Optional: expose the dbx-proxy health port via the NLB so callers can reach it directly
# (e.g. through the PrivateLink endpoint). If the health port is already used as a regular
# listener port, we skip creating this additional listener/TG to avoid a conflict.
resource "aws_lb_target_group" "health" {
  count = contains([for l in var.dbx_proxy_listener : l.port], var.dbx_proxy_health_port) ? 0 : 1

  name        = "tg-health"
  port        = var.dbx_proxy_health_port
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = local.vpc_id

  health_check {
    protocol            = "HTTP"
    port                = var.dbx_proxy_health_port
    path                = "/status"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 10
  }

  tags = local.tags
}

resource "aws_lb_listener" "health" {
  count = length(aws_lb_target_group.health)

  load_balancer_arn = aws_lb.this.arn
  port              = var.dbx_proxy_health_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.health[0].arn
  }
}

# One target group per listener port for simple configuration.
resource "aws_lb_target_group" "this" {
  for_each = { for l in var.dbx_proxy_listener : l.name => l }

  name        = "tg-${each.key}"
  port        = each.value.port
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = local.vpc_id

  health_check {
    protocol            = upper(each.value.mode)
    port                = var.dbx_proxy_health_port
    path                = each.value.mode == "http" ? "/status" : null
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 10
  }

  tags = local.tags
}

resource "aws_lb_listener" "this" {
  for_each = aws_lb_target_group.this

  load_balancer_arn = aws_lb.this.arn
  port              = each.value.port
  protocol          = upper(each.value.protocol)

  default_action {
    type             = "forward"
    target_group_arn = each.value.arn
  }
}
