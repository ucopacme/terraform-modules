locals {
  enabled = var.enabled == "true"
}
resource "aws_route_table" "this" {
  count = local.enabled ? 1 : 0
  tags  = merge(var.tags, map("Name", var.name))

  vpc_id = var.vpc_id
}

#kk changes
resource "aws_route_table" "private" {
  count = local.enabled ? 1 : 0
  tags  = join("-",merge(var.tags, map("Name", var.name))"Private_route")

  vpc_id = var.vpc_id
}


