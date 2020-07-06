output "tgw_rt_propagation" {
  value = join("", aws_ec2_transit_gateway_route_table_propagation.this.*.id)
}
