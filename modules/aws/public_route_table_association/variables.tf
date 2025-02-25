variable "enabled" {
  type        = string
  description = "Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

variable "subnet_id" {
  type        = string
  description = "subnet Id"
}

variable "route_table_id" {
  type        = string
  description = "Route Table Id"
}
