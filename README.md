# cngfw-azure-blog

[Cloud NGFW for Azure](https://www.paloaltonetworks.com/network-security/cloud-ngfw-for-azure) by Palo Alto Networks is natively integrated into the Azure Resource Manager framework and does not require the use of any vendor-specific APIs for deployment. 

In this blog, you will learn how to deploy and configure the Cloud NGFW resource using Terraform. Since Cloud NGFW is directly exposed in the Azure Portal and Azure APIs as a native service, it only requires the [Azure Terraform Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) to deploy and configure the resource.

For this deployment, we will create 2x Cloud NGFW resources to secure an Azure vWAN. One Cloud NGFW will be managed by Azure Rulestack, while the other will be managed by Panorama.
