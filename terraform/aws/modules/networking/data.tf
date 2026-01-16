data "aws_availability_zones" "this" {
  state = "available"
}

data "aws_subnet" "this" {
  for_each = { for idx, id in var.subnet_ids : tostring(idx) => id }
  id       = each.value
}
