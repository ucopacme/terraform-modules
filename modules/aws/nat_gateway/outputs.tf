output "nat_id" {
  description = "nat gateway id"
  value       = join("", aws_nat_gateway.this.*.id)
}
