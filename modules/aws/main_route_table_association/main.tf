locals {
  enabled = var.enabled == "true"
}
resource "aws_main_route_table_association" "this" {
  count = local.enabled ? 1 : 0

  route_table_id = var.route_table_id
  vpc_id         = var.vpc_id
}


resource "aws_route_table_association" "public" {
  count = local.public_count

  subnet_id      = element(modlue.aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.this.*.id, count.index)


  depends_on = [
    aws_subnet.public,
    aws_route_table.public,
  ]
}