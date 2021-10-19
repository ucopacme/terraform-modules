locals {
 enabled_nat_gateway = var.enabled_nat_gateway == "true"
}

resource "aws_nat_gateway" "this" {
  allocation_id = var.allocation_id
  count         = local.enabled_nat_gateway ? 1 : 0
  subnet_id     = var.subnet_id
  tags          = merge(var.tags, map("Name", var.name))
}

