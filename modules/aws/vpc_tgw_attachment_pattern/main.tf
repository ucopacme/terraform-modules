# vpc subnets tgw attachment
module "vpc_subnets_tgw_attachment" {
  enabled                                         = var.enabled
  name                                            = var.name_tgw_attachment
  source = "git::ssh://git@github.com/ucopacme/terraform-module.git//modules/aws/tgw_attachment?ref=v0.0.01"
  subnet_ids                                      = var.subnet_ids
  tags                                            = merge(var.tags, map("Name", var.name_tgw_attachment))
  transit_gateway_default_route_table_propagation = true
  transit_gateway_id                              = var.tgw_id
  vpc_id                                          = var.vpc_id
}

# vpc subnets tgw attachment tgw route table association
module "vpc_subnets_tgw_attachment_tgw_route_table_association" {
  enabled                        = var.enabled
  name                           = var.name_tgw_route_table_association
  source = "git::ssh://git@github.com/ucopacme/terraform-module.git//modules/aws/tgw_route_table_association?ref=v0.0.01"
  tags                           = merge(var.tags, map("Name", var.name_tgw_route_table_association))
  transit_gateway_attachment_id  = module.vpc_subnets_tgw_attachment.tgw_attachment_id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}

# vpc route consolidation
module "vpc_route_consolidation" {
  destination_cidr_block = var.destination_cidr_block
  enabled                = var.enabled
  name                   = var.name_route_consolidation
  route_table_id         = var.route_table_id
  source = "git::ssh://git@github.com/ucopacme/terraform-module.git//modules/aws/route?ref=v0.0.01"
  tags                   = merge(var.tags, map("Name", var.name_route_consolidation))
  transit_gateway_id     = var.tgw_id
}
