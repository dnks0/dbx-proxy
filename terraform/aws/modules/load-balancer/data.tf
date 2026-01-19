data "aws_lb" "this" {
  count = var.bootstrap_load_balancer == false ? 1 : 0
  arn   = var.nlb_arn
}
