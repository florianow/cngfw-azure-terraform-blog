output "documentation_md" {
  value = <<-EOF
# Palo Alto NGFW 

Connection to the hub is the pre-requisite for getting access to the on-prem network.

The hub itself has the following address space `${var.address_space}`.

Upon request, we will peer a VNet in your subscription with the hub.

All Firewall related logs are in the Log Anlytics Workspace
  

## Hub and spoke vnet-peering
| name | address_space | description |
|-|-|-|

## Subnets

| name | prefixes |
|-|-|

Access to the central Network Hub is granted on a need-to-know basis to Auditors and Cloud Foundation Team members.
The following Entra ID groups control access and are used to implement [Privileged Access Management](./azure-pam.md).

|group|description|
|-|-|
| ${azuread_group.network_admins.display_name} | ${azuread_group.network_admins.description} |

EOF
}
