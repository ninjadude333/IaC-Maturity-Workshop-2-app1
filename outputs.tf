output "APP-LoadBalancer-dns" {
  description = "Alb dns name"
  value       = module.terraform-AWS-Maturity_Workshop_App_module.output.APP-LoadBalancer-dns
}

output "private_key" {
  value     = module.terraform-AWS-Maturity_Workshop_App_module.output.private_key
  sensitive = true
}