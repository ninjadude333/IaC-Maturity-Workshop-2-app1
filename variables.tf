variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "TF_HCP_org_name" {
  description = "The Name of the HCP TF Organization."
  type        = string
  default     = "TeraSky"
}

variable "TF_HCP_workspace_name" {
  description = "The Name of the HCP TF workspace to query state from."
  type        = string
  default     = "IaC-Maturity-Workshop-1-vpc"
}

variable "aws_region" {
  description = "AWS Region to deploy stuff in"
  type        = string
  default     = "eu-west-2"
}
