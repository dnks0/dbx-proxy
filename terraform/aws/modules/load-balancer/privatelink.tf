# PrivateLink endpoint service for Databricks (only when creating a new NLB)
resource "aws_vpc_endpoint_service" "this" {
  count = var.bootstrap_load_balancer ? 1 : 0

  acceptance_required        = true
  network_load_balancer_arns = [local.nlb_arn]
  allowed_principals         = local.allowed_principals

  tags = merge(
    var.tags,
    {
      Name = "${var.prefix}-es"
    },
  )
}
