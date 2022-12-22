output "VPC_ID" {
  value = data.terraform_remote_state.vpc.outputs.VPC_ID
}
output "VPC_Private_Subnets" {
  value = data.terraform_remote_state.vpc.outputs.VPC_Private_Subnets
}
output "VPC_Public_Subnets" {
  value = data.terraform_remote_state.vpc.outputs.VPC_Public_Subnets
}
output "VPC_main_route_table_id" {
  value = data.terraform_remote_state.vpc.outputs.VPC_main_route_table_id
}