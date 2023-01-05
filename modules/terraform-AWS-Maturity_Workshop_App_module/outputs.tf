output "APP-LoadBalancer-dns" {
  description = "Alb dns name"
  value       = aws_lb.app_lb.dns_name
}

output "private_key" {
  value     = tls_private_key.keypair_prv_key.private_key_pem
  sensitive = true
}