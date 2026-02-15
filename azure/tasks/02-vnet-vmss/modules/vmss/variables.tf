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

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "vmss_subnet_id" {
  description = "Subnet ID where the single VMSS will be deployed."
  type        = string
}

variable "glb_subnet_id" {
  description = "The subnet ID for the GLB (Gateway Load Balancer / App Gateway) subnet. Optional, only needed if GLB appliances are deployed in the GLB subnet."
  type        = string
}

variable "vmss_nsg_id" {
  description = "The NSG ID for vmss subnets."
  type        = string
  default     = null
}

variable "glb_subnet_cidrs" {
  description = "The CIDR block(s) for the GLB (Gateway Load Balancer / App Gateway) subnet. Should be a /28 or smaller subnet."
  type        = list(string)
  default     = []
}

variable "vmss_subnet_cidrs" {
  description = "The CIDR block(s) for the VMSS subnets. Should be a /24 or smaller subnet."
  type        = list(string)
  default     = []
}

variable "vmss_routes" {
  description = "List of routes for VMSS subnet route table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
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

variable "platform_image" {
  description = "Optional platform image. If null, default Ubuntu 22.04 LTS is used."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = null
}

variable "size" {
  description = "The size of the virtual machines (SKU)."
  type        = string
}

variable "instances" {
  description = "Initial number of VM instances (used when autoscale is disabled; otherwise should be within [min_instances, max_instances])."
  type        = number
  default     = 1
}

variable "zones" {
  description = "Availability zones for the VMSS (e.g. [\"1\", \"2\", \"3\"]). Leave null for regional (no zones)."
  type        = list(string)
  default     = null
}

# Autoscale
variable "enable_autoscale" {
  description = "Enable Azure Monitor autoscale for the VMSS."
  type        = bool
  default     = false
}

variable "min_instances" {
  description = "Minimum number of instances (autoscale)."
  type        = number
  default     = 1
}

variable "max_instances" {
  description = "Maximum number of instances (autoscale)."
  type        = number
  default     = 10
}

variable "scale_out_cpu_percent" {
  description = "CPU percentage threshold to scale out (add instances)."
  type        = number
  default     = 75
}

variable "scale_in_cpu_percent" {
  description = "CPU percentage threshold to scale in (remove instances)."
  type        = number
  default     = 25
}

variable "ssh_public_key" {
  description = "The SSH public key for VM authentication."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

locals {
  platform_image = var.platform_image != null ? var.platform_image : {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
