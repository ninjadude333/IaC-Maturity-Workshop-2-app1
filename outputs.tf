output "APP--dns" {
  description = "Alb dns name"
  value       = module.terraform-AWS-Maturity_Workshop_App_module.app-dns
}

output "private_key" {
  value     = module.terraform-AWS-Maturity_Workshop_App_module.private_key
  sensitive = true
}