# locals {
#   enabled = var.enabled == "true"
# }

locals {
  enabled_nat_gateway = var.enabled_nat_gateway == "true"
}

resource "aws_eip" "this" {
  count  = local.enabled_nat_gateway ? 1 : 0
#  domain = "vpc"
  tags   = merge(var.tags, tomap({ "Name" = var.name }))
}
