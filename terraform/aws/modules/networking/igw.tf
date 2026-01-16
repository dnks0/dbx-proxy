# Internet Gateway for outbound connectivity (only when creating a new VPC)
resource "aws_internet_gateway" "this" {
  count = var.bootstrap_networking && var.enable_nat_gateway ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.prefix}-igw"
    },
  )
}
