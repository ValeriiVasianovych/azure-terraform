variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
}

variable "project_name" {
  description = "The name of the project for resource naming."
  type        = string
}

variable "vnet_cidr" {
  description = "The CIDR block for the virtual network."
  type        = string
}

variable "vmss_subnet_cidrs" {
  description = "The CIDR block for the vmss subnets."
  type        = list(string)
  default     = []
}

variable "vmss_routes" {
  description = "List of routes for vmss subnet vmss table. Each route should have: name, address_prefix, next_hop_type, and optionally next_hop_in_ip_address."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "glb_subnet_cidrs" {
  description = "The CIDR block for the gateway load balancer subnet. Should be a /28 or smaller subnet."
  type        = list(string)
  default     = []
}

variable "glb_routes" {
  description = "List of routes for gateway load balancer subnet route table. Each route should have: name, address_prefix, next_hop_type, and optionally next_hop_in_ip_address."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  type        = map(string)
  default     = {}
}
