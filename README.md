# terraform-aws-vpc
Terraform AWS vpc Module


-->

Terraform module to provision AWS [`vpc`]



## Introduction

The module will create:

* vpc Instance
* subnets
* route table
* route
* nat-gateway
* internet-gateway
* subnet association


## Usage
1. Create main.tf config file, copy/past the following configuration.


```
module "vpc" {
  source               = "git::https://git@github.com/ucopacme/terraform-modules.git//modules/aws/standard-its-vpc//?ref=v0.0.12"
  application          = "fix this "
  azs                  = ["us-west-2a", "us-west-2b"]
  cidr_block           = enter cidr block
  enabled              = "true"
  environment          = local.environment
  enabled_data_subnets = "true" # change to true to create data_subnet
  enabled_nat_gateway  = "true" # change to true to create nat-gatway
  name                 = join("-", [local.application, local.environment])
  tags = {
    "ucop:application" = local.application
    "ucop:createdBy"   = local.createdBy
    "ucop:environment" = local.environment
    "ucop:group"       = local.group
    "ucop:source"      = local.source
  }
}

locals {
  application = "xxx"
  createdBy   = "terraform"
  environment = "xxx"
  group       = "xxx"
  source      = join("/", ["https://github.com/ucopacme/ucop-terraform-deployments/terraform/xxx"])
}


##
2. Create output.tf config file, copy/past the following configuration.

output "vpc_id" {
  description = "virtual private cloud id"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "list of public subnet ids"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "list of private subnet ids"
  value       = module.vpc.private_subnet_ids
}
output "tgw_subnet_ids" {
  description = "list of tgw subnet ids"
  value       = module.vpc.tgw_subnet_ids
}



output "data_subnet_ids" {
  description = "list of data subnet ids"
  value       = module.vpc.data_subnet_ids
}

output "route_table_id" {
  description = "route table id"
  value       = module.vpc.route_table_id
}

output "main_route_table_association_id" {
  description = "route table id"
  value       = module.vpc.main_route_table_association_id
}

output "igw_id" {
  description = "internet gateway id"
  value       = module.vpc.igw_id
}

output "igw_route_id" {
  description = "internet gateway route id"
  value       = module.vpc.igw_route_id
}

##
3. Create backend.tf config file, copy/past the following configuration.


terraform {
  backend "remote" {
    hostname     = "scalr.io" # enter our scalr url
    organization = "env-id" # enter the organization id of the account you deploy.

    workspaces {
      name = "vpc-prod-vpc" # enter the worksapces name
    }
  }
}
