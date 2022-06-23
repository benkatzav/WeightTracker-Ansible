# WeightTracker - Ansible & Terraform
Using Ansible in order to install the Weight Tracker app and everything it requires through all its application servers
& Using Terraform to build the infrastructure of the Weight Tracker application

## Infrastructure Diagram: (Treat the VMs inside the web tier as Scale Set)
![TOPOLOGY](https://user-images.githubusercontent.com/88583978/173969411-c62c8e3d-83ec-40d5-afd7-db42da983d7a.png)

## Description:
1. The Terraform template created is used to provision the required infrastructure as defined in the diagram in two environment on for staging and one for production
2. Used PostgreSQL managed databased (flexible) that is not accessible from the internet
3. Using Auto-Scaling which increases the number of VM instances in the scale set when the load is increased (application demand increased)
4. The Ansible playbooks are used to deploy the Weight Tracker application - cloning the git repo, installing nodejs and everything else the app requires. 
5. Everything is automated, once you initiate the infrastructure using terraform init, plan, apply all you need to go to your control machine configure the application hosts and your OKTA and Postgres info in the ```hosts.ini``` file in the inventory folder and run the ansible playbook using the following command ```ansible-playbook webservers.yml```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.0.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_loadbalancer"></a> [loadbalancer](#module\_loadbalancer) | ./modules/loadbalancer | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_postgres"></a> [postgres](#module\_postgres) | ./modules/postgres | n/a |
| <a name="module_vmss"></a> [vmss](#module\_vmss) | ./modules/vmss | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.bpepool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_nat_pool.lbnatpool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_pool) | resource |
| [azurerm_lb_probe.lb_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.LB_rule8080](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_linux_virtual_machine_scale_set.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_network_security_group.apps_set_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.db_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_postgresql_flexible_server.postgres_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.db-config-no-ssl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_firewall_rule.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) | resource |
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_vnl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.app_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.app_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.db_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_range"></a> [address\_range](#input\_address\_range) | Define the app's IP address range | `string` | `"Address range defined in tfvars file"` | no |
| <a name="input_admin_ip_address"></a> [admin\_ip\_address](#input\_admin\_ip\_address) | Define your IP address | `string` | `"IP defined in tfvars file"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Define password for the VMs of the Scale Set | `string` | `"password is defined in tfvars file"` | no |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | Admin username of the VMs that will be part of the VM scale set | `string` | `"admin user defined in tfvars file"` | no |
| <a name="input_packer_image_name"></a> [packer\_image\_name](#input\_packer\_image\_name) | Define your IMG name | `string` | `"IMG defined in tfvars file"` | no |
| <a name="input_packer_resource_group_name"></a> [packer\_resource\_group\_name](#input\_packer\_resource\_group\_name) | Define your IMGs group name | `string` | `"IMGs group name defined in tfvars file"` | no |
| <a name="input_pg_password"></a> [pg\_password](#input\_pg\_password) | Define password for postgres | `string` | `"Password defined in tfvars file"` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | Define your resource group name | `string` | n/a | yes |
| <a name="input_server_location"></a> [server\_location](#input\_server\_location) | Define your server location | `string` | n/a | yes |
| <a name="input_subnet_address_cidr"></a> [subnet\_address\_cidr](#input\_subnet\_address\_cidr) | Define subnet address CIDR | `list(string)` | n/a | no |
| <a name="input_vm_config"></a> [vm\_config](#input\_vm\_config) | Define your VM size | `string` | `"Standard_B2s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vmss_password"></a> [vmss\_password](#output\_vmss\_password) | n/a |
