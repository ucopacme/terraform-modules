locals {
  enabled = var.enabled == "true"
}

resource "aws_instance" "this" {
  ami                         = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  count                       = local.enabled ? 1 : 0
  iam_instance_profile        = var.iam_instance_profile
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  tags                        = merge(var.tags, map("Name", var.name))
  vpc_security_group_ids      = var.vpc_security_group_ids
}
