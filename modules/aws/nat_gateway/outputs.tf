output "nat_ids" {
  description = "List of NAT Gateway IDs"
  value       = join("", aws_nat_gateway.this.*.id)
}