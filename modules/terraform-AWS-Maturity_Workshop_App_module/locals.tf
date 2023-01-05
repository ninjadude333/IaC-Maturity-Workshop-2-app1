locals {
  vpc_azs = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  tags = {
    Owner     = "David Gidony"
    App       = var.app_name
    Terraform = "True"
    Purpose   = "Maturity-Workshop"
  }
}