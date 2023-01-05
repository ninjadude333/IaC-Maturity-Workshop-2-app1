#variable "aws_access_key" {
#  type = string
#}
#
#variable "aws_secret_key" {
#  type = string
#}

variable "vpc_name" {
  description = "The Name of the VPC."
  type        = string
}

variable "vpc_id" {
  description = "The Name of the VPC."
  type        = string
}

variable "aws_region" {
  description = "AWS Region to deploy the VPC in"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
  description = "List of private subnets to create in VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets" {
  description = "List of public subnets to create in VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "vpc_public_subnet_ids" {
  description = "List of public subnets to create in VPC"
  type        = list(string)
}

variable "keypair_name" {
  description = "keypair_name"
  type        = string
  default     = "matureSSH"
}

variable "app_name" {
  type    = string
  default = "myApp"
}