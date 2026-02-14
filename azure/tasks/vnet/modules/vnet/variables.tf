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

variable "public_subnet_cidrs" {
  description = "The CIDR block for the public subnets."
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "The CIDR block for the private subnets."
  type        = list(string)
  default     = []
}

variable "public_routes" {
  description = "List of routes for public subnet route table. Each route should have: name, address_prefix, next_hop_type, and optionally next_hop_in_ip_address."
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

variable "private_routes" {
  description = "List of routes for private subnet route table. Each route should have: name, address_prefix, next_hop_type, and optionally next_hop_in_ip_address."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "nat_gateway_idle_timeout" {
  description = "Idle timeout in minutes for NAT Gateway."
  type        = number
  default     = 10
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  type        = map(string)
  default     = {}
}
