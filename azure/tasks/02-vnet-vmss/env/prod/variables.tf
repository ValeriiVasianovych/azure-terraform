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

variable "glb_subnet_cidrs" {
  description = "The CIDR block(s) for the GLB (Gateway Load Balancer / App Gateway) subnets."
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "glb_routes" {
  description = "List of routes for GLB subnet route table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "glb_size" {
  description = "The size of the virtual appliances in GLB subnet (if any)."
  type        = string
  default     = "Standard_B1s"
}

variable "glb_zones" {
  description = "Availability zones for GLB subnet resources (e.g. [\"1\", \"2\", \"3\"]). Null = regional (no zones)."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "vmss_subnet_cidrs" {
  description = "The CIDR block for the vmss subnets."
  type        = list(string)
  default     = ["10.0.20.0/24"]
}

variable "vmss_routes" {
  description = "List of routes for vmss subnet route table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "size" {
  description = "The size of the virtual machines (SKU)."
  type        = string
  default     = "Standard_B1s"
}

variable "vmss_instances" {
  description = "Initial number of instances in the VMSS."
  type        = number
  default     = 1
}

variable "vmss_zones" {
  description = "Availability zones for VMSS (e.g. [\"1\", \"2\", \"3\"]). Null = regional (no zones)."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "enable_autoscale" {
  description = "Enable Azure Monitor autoscale (min/max and CPU-based rules)."
  type        = bool
  default     = false
}

variable "min_instances" {
  description = "Minimum instances when autoscale is enabled."
  type        = number
  default     = 1
}

variable "max_instances" {
  description = "Maximum instances when autoscale is enabled."
  type        = number
  default     = 10
}

variable "scale_out_cpu_percent" {
  description = "CPU % threshold to add an instance."
  type        = number
  default     = 75
}

variable "scale_in_cpu_percent" {
  description = "CPU % threshold to remove an instance."
  type        = number
  default     = 25
}

variable "ssh_keys_rg" {
  description = "The resource group where SSH keys are stored."
  type        = string
}

variable "ssh_key_name" {
  description = "The name of the SSH public key resource in Azure."
  type        = string
}