variable "application" {
  description = "Application name, eg ucpath, applyuc, annualwage, etc"
  type        = string
}

variable "azs" {
  #default     = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  default     = ["us-west-2a", "us-west-2b"]
  type        = list(string)
  description = "Availability zones to occupy"
}

variable "pub_azs" {
  #default     = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  default     = ["us-west-2a", "us-west-2b"]
  type        = list(string)
  description = "Availability zones to occupy"
}

variable "cidr_block" {
  type        = string
  description = "CIDR for VPC"
}

variable "enabled" {
  type        = string
  description = "Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

variable "enabled_data_subnets" {
  type        = bool
  description = "Set to `false` to prevent the module from creating data subnets"
  default     = false
}

variable "enabled_public_subnets" {
  type        = bool
  description = "Set to `false` to prevent the module from creating public subnets"
  default     = true
}

variable "environment" {
  description = "environment, eg dev, qa, prod "
  type        = string
}

variable "name" {
  description = "name, to be used as prefix for all resource names"
  type        = string
}

variable "public_subnet_index" {
  description = "index of public subnet"
  default     = 0
  type        = number
}

variable "tgw_subnet_index" {
  description = "index of tgw subnet"
  default     = 1
  type        = number
}

variable "private_subnet_index" {
  description = "index of private subnet"
  default     = 2
  type        = number
}

variable "data_subnet_index" {
  description = "index of data subnet"
  default     = 3
  type        = number
}

variable "subnet_tier_bits" {
  default     = 2
  type        = number
  description = "number of bits to allocate to subnet tiers, 3 means 8 different tier blocks"
}

variable "public_subnet_tier_bits" {
  default     = null
  type        = number
  description = "number of bits to allocate to public subnet tier (instead of using generic subnet_tier_bits)"
}

variable "tgw_subnet_tier_bits" {
  default     = null
  type        = number
  description = "number of bits to allocate to tgw subnet tier (instead of using generic subnet_tier_bits)"
}

variable "private_subnet_tier_bits" {
  default     = null
  type        = number
  description = "number of bits to allocate to private subnet tier (instead of using generic subnet_tier_bits)"
}

variable "data_subnet_tier_bits" {
  default     = null
  type        = number
  description = "number of bits to allocate to data subnet tier (instead of using generic subnet_tier_bits)"
}

variable "tags" {
  default     = {}
  description = "A map of tags to add to all resources"
  type        = map(string)
}

# variable "allocation_id" {
#   type        = string
#   description = "Allocation ID"
# }

variable "enabled_nat_gateway" {
  type        = string
  description = "Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

# variable "enabled_nat_route" {
#   type        = string
#   description = "Set to `false` to prevent the module from creating any resources"
#   default     = "true"
# }

variable "enabled_igw_route" {
  type        = string
  description = "Set to `false` to prevent the module from creating any resources"
  default     = "true"
}
