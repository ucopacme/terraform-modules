# locals {
#   enabled = var.enabled == "true"
# }

locals {
  enabled_nat_gateway = var.enabled_nat_gateway == "true"
  
}
resource "aws_eip" "this" {
  count = local.enabled_nat_gateway ? 1 : 0
  vpc   = true
  tags  = merge(var.tags, map("Name", var.name))
}
