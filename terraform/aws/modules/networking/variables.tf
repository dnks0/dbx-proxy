variable "prefix" {
  description = "Prefix for all AWS resources created by this module."
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to all resources created by this module."
  type        = map(string)
}

variable "bootstrap_networking" {
  description = "Whether to bootstrap a new network."
  type        = bool
}

variable "vpc_id" {
  description = "ID of the VPC in which to deploy the dbx-proxy instances. If null, a new VPC will be bootstrapped."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC when bootstrapping a VPC."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the dbx-proxy instance and NLB. If empty, new subnets will be created."
  type        = list(string)
}

variable "subnet_cidrs" {
  description = "CIDR blocks for subnets when bootstrapping a VPC."
  type        = list(string)
}

variable "nat_subnet_cidr" {
  description = "CIDR block for the public subnet used by the NAT gateway when creating a VPC."
  type        = string
}

variable "enable_nat_gateway" {
  description = "Whether to create an Internet Gateway and NAT Gateway for outbound internet connectivity when creating a new VPC."
  type        = bool
}
