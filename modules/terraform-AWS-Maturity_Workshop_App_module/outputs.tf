output "app-dns" {
  value = "http://${aws_route53_record.app.name}"
}

output "private_key" {
  value     = tls_private_key.keypair_prv_key.private_key_pem
  sensitive = true
}

output "AWS_VPC_link" {
  value = "https://${var.aws_region}.console.aws.amazon.com/vpc/home?region=${var.aws_region}#vpcs:tag:Phase=three"
}