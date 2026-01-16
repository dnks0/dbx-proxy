# Elastic IP and NAT Gateway for private subnet egress
resource "aws_eip" "this" {
  count = var.bootstrap_networking && var.enable_nat_gateway ? 1 : 0

  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.prefix}-nat-eip"
    },
  )
}

resource "aws_nat_gateway" "this" {
  count = var.bootstrap_networking && var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.this[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.tags,
    {
      Name = "${var.prefix}-nat"
    },
  )

  depends_on = [aws_internet_gateway.this]
}
