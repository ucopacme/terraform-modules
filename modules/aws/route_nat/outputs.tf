output "id" {
  value = join("", aws_route.nat.*.id)
}
