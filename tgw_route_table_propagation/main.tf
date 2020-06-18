locals {
  enabled = var.enabled == "true"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  count = local.enabled ? 1 : 0
  # not taggable
  # tags                           = merge(var.tags, map("Name", var.name))
  transit_gateway_attachment_id  = var.transit_gateway_attachment_id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}
