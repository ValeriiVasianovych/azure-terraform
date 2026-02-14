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

variable "public_subnet_ids" {
  description = "List of public subnet IDs where VMs will be deployed."
  type        = list(string)
  default     = []
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where VMs will be deployed."
  type        = list(string)
  default     = []
}

variable "public_nsg_id" {
  description = "The NSG ID for public subnets."
  type        = string
  default     = null
}

variable "private_nsg_id" {
  description = "The NSG ID for private subnets."
  type        = string
  default     = null
}

variable "platform_image" {
  description = "The platform image reference to use for the virtual machines."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "size" {
  description = "The size of the virtual machines."
  type        = string
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
