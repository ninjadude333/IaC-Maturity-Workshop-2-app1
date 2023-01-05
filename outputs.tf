output "APP-LoadBalancer-dns" {
  description = "Alb dns name"
  value       = module.terraform-AWS-Maturity_Workshop_App_module.outputs.APP-LoadBalancer-dns
}

output "private_key" {
  value     = module.terraform-AWS-Maturity_Workshop_App_module.outputs.private_key
  sensitive = true
}