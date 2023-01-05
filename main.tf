# Get VPC information from remote state
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = var.TF_HCP_org_name
    workspaces = {
      name = var.TF_HCP_workspace_name
    }
  }
}

module "terraform-AWS-Maturity_Workshop_App_module" {
  source = "./modules/terraform-AWS-Maturity_Workshop_App_module"

  app_name              = var.App_Name
  vpc_name              = data.terraform_remote_state.vpc.outputs.VPC_NAME
  vpc_id                = data.terraform_remote_state.vpc.outputs.VPC_ID
  aws_region            = var.aws_region
  vpc_cidr              = data.terraform_remote_state.vpc.outputs.VPC_CIDR
  vpc_private_subnets   = data.terraform_remote_state.vpc.outputs.VPC_Private_Subnets
  vpc_public_subnet_ids = data.terraform_remote_state.vpc.outputs.VPC_Public_Subnets
  keypair_name          = var.key_pair_Name
  aws_access_key        = var.aws_access_key
  aws_secret_key        = var.aws_secret_key
}