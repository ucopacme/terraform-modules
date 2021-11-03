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
Create terragrunt.hcl config file, copy/past the following configuration.


```hcl


# Include all settings from root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  azs                  = local.common_vars.network.vpcs.ucop-iam-uat.azs
  cidr_block           = local.common_vars.network.vpcs.ucop-iam-uat.cidr_blocks
  enabled              = "true"
  enabled_data_subnets = "false" # change to true to create data_subnet
  enabled_nat_gateway  = "false" # change to true to create nat-gatway
  name = join("-", [local.application, local.environment
  ])
  tags = {
    "ucop:application" = local.application
    "ucop:createdBy"   = local.createdBy
    "ucop:environment" = local.environment
    "ucop:group"       = local.group
    "ucop:source"      = local.source
  }
}


locals {
  common_vars = jsondecode(file("../../../../common_vars.json"))
  application = local.common_vars.applications.ucop-iam-uat.label
  createdBy   = "terraform"
  environment = local.common_vars.environments.dev.label
  group       = local.common_vars.groups.chs.label
  source      = join("/", ["https://github.com/ucopacme/ucop-terraform-config/tree/master/terraform/its-chs-dev/us-west-2", path_relative_to_include()])
}


terraform {
   source = "git::https://git@github.com/ucopacme/terraform-modules.git//modules/aws/standard-its-vpc//?ref=v0.0.9"
  
}
