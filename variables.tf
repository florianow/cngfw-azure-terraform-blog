variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where resources will be created."
}

variable "region" {
  type        = string
  description = "The secondary region for deploying resources."
}

variable "network_admin_group" {
  type        = string
  description = "The name of the Azure AD group that will have network administration privileges."
  default     = "NetworkAdmins"
}

variable "connectivity_scope" {
  type        = string
  description = "The scope for connectivity management permissions."
}

variable "landingzone_scope" {
  type        = string
  description = "The scope for landing zone management permissions."
}

variable "cloudfoundation" {
  type        = string
  description = "The name of the Cloud Foundation."
  default     = "MyCloudFoundation"
}

variable "cloudfoundation_deploy_principal_id" {
  type        = string
  description = "The principal ID that will be granted permissions to deploy resources in this subscription."
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "hub_name" {
  description = "The name of the hub"
  type        = string
}

variable "pa_ngfw_name" {
  description = "Name of the Palo Alto NGFW"
  type        = string
}
