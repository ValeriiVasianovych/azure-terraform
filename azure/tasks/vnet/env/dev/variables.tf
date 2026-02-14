variable "subscription_id" {
  description = "The subscription ID for the Azure account."
  type        = string
  sensitive   = true
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "West Europe"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "The name of the project for resource naming."
  type        = string
  default     = "az-vnet"
}

variable "vnet_cidr" {
  description = "The CIDR block for the virtual network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR block for the public subnets."
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR block for the private subnets."
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24"]
}

variable "public_routes" {
  description = "List of routes for public subnet route table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = [{
    name                   = "route-to-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  }]
}

variable "enable_nat_gateway" {
  description = "Flag to enable or disable NAT Gateway for private subnets."
  type        = bool
  default     = true
}

variable "private_routes" {
  description = "List of routes for private subnet route table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

# VMs Module Variables
variable "size" {
  description = "The size of the virtual machines."
  type        = string
  default     = "Standard_B1s"
}

variable "ssh_keys_rg" {
  description = "The resource group where SSH keys are stored."
  type        = string
}

variable "ssh_key_name" {
  description = "The Key Vault name where SSH keys are stored."
  type        = string
}

variable "public_vms_nsg_ids" {
  description = "List of Network Security Group IDs to associate with public VMs."
  type        = list(string)
  default     = [80, 443, 22]
}

variable "private_vms_nsg_ids" {
  description = "List of Network Security Group IDs to associate with private VMs."
  type        = list(string)
  default     = [22]
}
