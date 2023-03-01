locals {
  vpc_azs = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  timestamp = timestamp()
  tags = {
    Owner     = "David Gidony"
    Env       = "Maturity-Workshop"
    Terraform = "True"
    Phase     = var.Phase
    Keep            = "True"
    "IAM User Name" = "davidg@terasky.com"
    "Creation Date" = "${formatdate("YYYY-MM-DD hh:mm:ss", local.timestamp)}"
  }
}