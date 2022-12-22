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