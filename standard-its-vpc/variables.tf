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

variable "cidr_block" {
  type        = string
  description = "CIDR for VPC"
}

variable "enabled" {
  type        = string
  description = "Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

variable "environment" {
  description = "environment, eg dev, qa, prod "
  type        = string
}

variable "name" {
  description = "name, to be used as prefix for all resource names"
  type        = string
}

variable "tags" {
  default     = {}
  description = "A map of tags to add to all resources"
  type        = map(string)
}
