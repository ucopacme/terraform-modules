output vpc_id {
  description = "virtual private cloud id"
  value       = module.vpc.vpc_id
}

output public_subnet_ids {
  description = "list of public subnet ids"
  value       = module.vpc_public_subnets.subnet_ids
}

output tgw_subnet_ids {
  description = "list of tgw subnet ids"
  value       = module.vpc_tgw_subnets.subnet_ids
}

output private_subnet_ids {
  description = "list of private subnet ids"
  value       = module.vpc_private_subnets.subnet_ids
}

output data_subnet_ids {
  description = "list of data subnet ids"
  value       = module.vpc_data_subnets.subnet_ids
}

output route_table_id {
  description = "route table id"
  value       = module.vpc_route_table.id
}

output main_route_table_association_id {
  description = "route table id"
  value       = module.vpc_route_table_main_route_table_association.id
}

output igw_id {
  description = "internet gateway id"
  value       = module.vpc_igw.id
}

output igw_route_id {
  description = "internet gateway route id"
  value       = module.vpc_route_for_igw.id
}

output nat_ids {
  description = "List of NAT Gateway IDs"
  value       = module.vpc_nat_gateway.nat_ids
}

output nat_route_id {
  description = "nat gateway route id"
  value       = module.vpc_route_for_nat.id
}

output vpc_cidr_block {
  description = "virtual private cloud CIDR block"
  value       = module.vpc.vpc_cidr_block
}
