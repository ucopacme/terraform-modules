locals {
  enabled = var.enabled == "true"
}

resource "aws_route_table_association" "public" {
  count          = local.enabled ? 1 : 0
  subnet_id      = var.subnet_id
  route_table_id = var.route_table_id
}
