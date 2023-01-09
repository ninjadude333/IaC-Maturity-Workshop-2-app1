variable "TF_HCP_org_name" {
  description = "The Name of the HCP TF Organization."
  type        = string
  default     = "TeraSky"
}

variable "TF_HCP_workspace_name" {
  description = "The Name of the HCP TF workspace to query state from."
  type        = string
  default     = "IaC-Maturity-Workshop-Phase3-vpc"
}

variable "aws_region" {
  description = "AWS Region to deploy stuff in"
  type        = string
  default     = "eu-west-2"
}

variable "key_pair_Name" {
  type    = string
  default = "mature-app1"
}

variable "App_Name" {
  type    = string
  default = "app1"
}

variable "Phase" {
  description = "demo phase"
  type        = string
  default     = "three"
}