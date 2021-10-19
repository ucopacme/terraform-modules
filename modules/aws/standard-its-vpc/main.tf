# vpc
module "vpc" {
  cidr_block = var.cidr_block
  enabled    = var.enabled
  name       = join("-", [var.name, "vpc"])
  source     = "../vpc"
  tags       = merge(var.tags, map("Name", var.name))
}

# vpc public subnets module
module "vpc_public_subnets" {
  availability_zones = var.azs
  enabled            = var.enabled
  name               = join("-", [var.name, "vpc-public-subnet"])
  new_bits           = "2"
  source             = "../vpc_subnets"
  subnet_cidr        = cidrsubnet(var.cidr_block, var.subnet_tier_bits, var.public_subnet_index)
  tags               = merge(var.tags, map("Name", var.name))
  vpc_id             = module.vpc.vpc_id
}

# vpc tgw subnets module
module "vpc_tgw_subnets" {
  availability_zones = var.azs
  enabled            = var.enabled
  name               = join("-", [var.name, "vpc-tgw-subnet"])
  new_bits           = "2"
  source             = "../vpc_subnets"
  subnet_cidr        = cidrsubnet(var.cidr_block, var.subnet_tier_bits, var.tgw_subnet_index)
  tags               = merge(var.tags, map("Name", var.name))
  vpc_id             = module.vpc.vpc_id
}

# vpc private subnets module
module "vpc_private_subnets" {
  availability_zones = var.azs
  enabled            = var.enabled
  name               = join("-", [var.name, "vpc-private-subnet"])
  new_bits           = "2"
  source             = "../vpc_subnets"
  subnet_cidr        = cidrsubnet(var.cidr_block, var.subnet_tier_bits, var.private_subnet_index)
  tags               = merge(var.tags, map("Name", var.name))
  vpc_id             = module.vpc.vpc_id
}

# vpc data subnets module
module "vpc_data_subnets" {
  availability_zones = var.azs
  enabled            = var.enabled
  name               = join("-", [var.name, "vpc-data-subnet"])
  new_bits           = "2"
  source             = "../vpc_subnets"
  subnet_cidr        = cidrsubnet(var.cidr_block, var.subnet_tier_bits, var.data_subnet_index)
  tags               = merge(var.tags, map("Name", var.name))
  vpc_id             = module.vpc.vpc_id
}

# vpc route table
module "vpc_route_table" {
  enabled = var.enabled
  name    = join("-", [var.name, "vpc-route-table"])
  source  = "../route_table"
  tags    = merge(var.tags, map("Name", var.name))
  vpc_id  = module.vpc.vpc_id
}
# AWS eip 

module "vpc_eip"{
  enabled_nat_gateway      = var.enabled_nat_gateway
  name          = join("-", [var.name, "nat-gateway-eip"])       
  source         = "../eip"
  tags          = merge(var.tags, map("Name", var.name))

}

# AWS nat gatewawy

module "vpc_nat_gateway"{
  enabled_nat_gateway       = var.enabled_nat_gateway
  name          = join("-", [var.name, "nat-gateway"])       
  source         = "../nat_gateway"
  allocation_id   = module.vpc_eip.allocation_id
  subnet_id     = element(module.vpc_private_subnets.subnet_ids, 0)
  tags          = merge(var.tags, map("Name", var.name))

}

# vpc route table main route table association
module "vpc_route_table_main_route_table_association" {
  enabled        = var.enabled
  name           = join("-", [var.name, "vpc-route-table-main-route-table-association"])
  source         = "../main_route_table_association"
  tags           = merge(var.tags, map("Name", var.name))
  route_table_id = module.vpc_route_table.id
  vpc_id         = module.vpc.vpc_id
  # subnet_id = module.vpc_public_subnets.id
}


module "vpc_route_table_public_route_table_association" {
  source         = "../public_route_table_association"
  route_table_id = module.vpc_route_table.route_id
  subnet_id      =element(module.vpc_public_subnets.subnet_ids, 0)

}

# vpc internet gateway
module "vpc_igw" {
  enabled = var.enabled
  name    = join("-", [var.name, "vpc-igw"])
  source  = "../internet_gateway"
  tags    = merge(var.tags, map("Name", var.name))
  vpc_id  = module.vpc.vpc_id
}


# vpc route for internet gateway
module "vpc_route_for_igw" {
  enabled                = var.enabled
  name                   = join("-", [var.name, "vpc-route-for-igw"])
  source                 = "../route"
  tags                   = merge(var.tags, map("Name", var.name))
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc_igw.id
  route_table_id         = module.vpc_route_table.route_id
  # route_table_id         = module.vpc_route_table.route_id
}

module "vpc_route_for_nat" {
  # enabled                = var.enabled
  enabled_nat_gateway      = var.enabled_nat_gateway
  name                   = join("-", [var.name, "vpc-route-for-nat-gateway"])
  source                 = "../route_nat"
  tags                   = merge(var.tags, map("Name", var.name))
  destination_cidr_block = "0.0.0.0/0"
  # nat_gateway_id         = element(module.vpc_nat_gateway.nat_ids, 0)
  nat_gateway_id         = module.vpc_nat_gateway.nat_ids
  # route_table_id         = "rtb-015119eceb4f97947"
  route_table_id         = module.vpc_route_table.id
}

module "vpc_route_for_igw_private" {
  # enabled                = var.enabled
  enabled_igw_route      = var.enabled_igw_route
  name                   = join("-", [var.name, "vpc-route-for-igw-route"])
  source                 = "../route_igw"
  tags                   = merge(var.tags, map("Name", var.name))
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc_igw.id
  route_table_id         = module.vpc_route_table.route_id
}