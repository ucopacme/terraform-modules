locals {
  enabled = var.enabled == "true"
}
resource "aws_route_table" "this" {
  count = local.enabled ? 1 : 0
  # tags  = merge(var.tags, map("Name", var.name))
  tags = merge(var.tags, map("Name", join("-", [var.name, "private-route"])))

  vpc_id = var.vpc_id
}

#kk changes
resource "aws_route_table" "private" {
  count = local.enabled ? 1 : 0
  # tags  = merge(var.tags, map("Name", var.name))
  tags = merge(var.tags, map("Name", join("-", [var.name, "public-route"])))

  vpc_id = var.vpc_id
}


