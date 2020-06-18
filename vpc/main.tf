locals {
  enabled = var.enabled == "true"
}
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  count                = local.enabled ? 1 : 0
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(var.tags, map("Name", var.name))
}
