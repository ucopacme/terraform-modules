locals {
  enabled = var.enabled == "true"
}
resource "aws_main_route_table_association" "this" {
  count = local.enabled ? 1 : 0

  route_table_id = var.route_table_id
  vpc_id         = var.vpc_id
}


# resource "aws_route_table_association" "public" {
#   # count = local.public_count

#   subnet_id      = var.public_subnet_id
#   route_table_id = var.route_table_id


#   depends_on = [
#     aws_subnet.public,
#     aws_route_table.public,
#   ]
# }