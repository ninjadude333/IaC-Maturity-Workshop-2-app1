# Get VPC information from remote state
data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "G:\\My Drive\\projects\\TF-IaC-Maturity-Workshop\\IaC-Maturity-Workshop-1-vpc\\terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = var.TF_HCP_org_name
    workspaces = {
      name = var.TF_HCP_workspace_name
    }
  }
}