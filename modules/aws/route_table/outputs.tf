output "id" {
  value = join("", aws_route_table.this.*.id)
}

output "route_id" {
  value = join("", aws_route_table.private.*.id)
}