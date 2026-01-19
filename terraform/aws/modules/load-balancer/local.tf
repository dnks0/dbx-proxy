locals {

  nlb_arn      = var.bootstrap_load_balancer ? aws_lb.this[0].arn : data.aws_lb.this[0].arn
  nlb_dns_name = var.bootstrap_load_balancer ? aws_lb.this[0].dns_name : data.aws_lb.this[0].dns_name
  nlb_zone_id  = var.bootstrap_load_balancer ? aws_lb.this[0].zone_id : data.aws_lb.this[0].zone_id

  allowed_principals = [
    "arn:aws:iam::565502421330:role/private-connectivity-role-${var.region}"
  ]

}
