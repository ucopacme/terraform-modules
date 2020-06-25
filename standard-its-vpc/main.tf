# vpc
module "vpc" {
  cidr_block = var.cidr_block
  enabled    = var.enabled
  name       = join("-", [var.name,"vpc"])
  source     = "../vpc"
  tags                 = merge(var.tags, map("Name", var.name))
}

# vpc public subnets module
module "vpc_public_subnets" {
  availability_zones = var.azs
  enabled    = var.enabled
  name       = join("-", [var.name,"vpc"])
  new_bits           = "2"
  source             = "../vpc_subnets"
  subnet_cidr = cidrsubnet(var.cidr_block, 3, 0)
  tags                 = merge(var.tags, map("Name", var.name))
  vpc_id      = module.vpc.vpc_id
}

# vpc tgw subnets module
module "vpc_tgw_subnets" {
  availability_zones = var.azs
  enabled    = var.enabled
  name               = join("-", [var.name, "vpc-tgw-subnet"])
  new_bits           = "2"
  source             = "../vpc_subnets"
  subnet_cidr = cidrsubnet(var.cidr_block, 3, 1)
  tags                 = merge(var.tags, map("Name", var.name))
  vpc_id      = module.vpc.vpc_id
}

# vpc private subnets module
module "vpc_private_subnets" {
  availability_zones = var.azs
  enabled    = var.enabled
  name               = join("-", [var.name, "vpc-private-subnet"])
  new_bits           = "2"
  source             = "../vpc_subnets"
  subnet_cidr = cidrsubnet(var.cidr_block, 3, 2)
  tags                 = merge(var.tags, map("Name", var.name))
  vpc_id      = module.vpc.vpc_id
}

# vpc data subnets module
module "vpc_data_subnets" {
  #availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  availability_zones = var.azs
  enabled    = var.enabled
  name               = join("-", [var.name, "vpc-data-subnet"])
  new_bits           = "2"
  source             = "../vpc_subnets"
  subnet_cidr        = cidrsubnet(var.cidr_block, 3, 4)
  tags                 = merge(var.tags, map("Name", var.name))
  vpc_id = module.vpc.vpc_id
}

# vpc route table
module "vpc_route_table" {
  enabled    = var.enabled
  name    = join("-", [var.name, "vpc-route-table"])
  source  = "../route_table"
  tags                 = merge(var.tags, map("Name", var.name))
  vpc_id = module.vpc.vpc_id
}

# vpc route table main route table association
module "vpc_route_table_main_route_table_association" {
  enabled    = var.enabled
  name           = join("-", [var.name, "vpc-route-table-main-route-table-association"])
  source         = "../main_route_table_association"
  tags                 = merge(var.tags, map("Name", var.name))
  route_table_id = module.vpc_route_table.id
  vpc_id         = module.vpc.vpc_id
}

# vpc internet gateway 
module "vpc_igw" {
  enabled    = var.enabled
  name    = join("-", [var.name, "vpc-igw"])
  source  = "../internet_gateway"
  tags                 = merge(var.tags, map("Name", var.name))
  vpc_id  = module.vpc.vpc_id
}

# vpc route for internet gateway
module "vpc_route_for_igw" {
  enabled    = var.enabled
  name                   = join("-", [var.name, "vpc-route-for-igw"])
  source                 = "../route"
  tags                 = merge(var.tags, map("Name", var.name))
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc_igw.id
  route_table_id         = module.vpc_route_table.id
}
