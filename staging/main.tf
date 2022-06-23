# Creates the resource group
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.server_location
}

# Creates the network
module "network" {
  source              = "./modules/network"
  rg_name             = azurerm_resource_group.rg.name
  server_location     = azurerm_resource_group.rg.location
  subnet_address_cidr = var.subnet_address_cidr
  admin_ip_address    = var.admin_ip_address
  address_range       = var.address_range
}

# Creates the LoadBalancer
module "loadbalancer" {
  source          = "./modules/loadbalancer"
  rg_name         = azurerm_resource_group.rg.name
  server_location = azurerm_resource_group.rg.location
  app_public_ip   = module.network.app_public_ip
}

# Creates the VMs Scale Set
module "vmss" {
  source          = "./modules/vmss"
  rg_name         = azurerm_resource_group.rg.name
  server_location = azurerm_resource_group.rg.location
  apps_set_nsg    = module.network.apps_set_nsg
  apps_subnet     = module.network.apps_subnet
  lbnatpool       = module.loadbalancer.lbnatpool
  bpepool         = module.loadbalancer.bpepool
  admin_user      = var.admin_user
  admin_password  = var.admin_password
  vm_config       = "Standard_B1s"
  vmss_name       = "scale-machine-stag"
}

# Creates the postgreSQL server (managed database)
module "postgres" {
  source          = "./modules/postgres"
  rg_name         = azurerm_resource_group.rg.name
  server_location = azurerm_resource_group.rg.location
  db_subnet       = module.network.db_subnet
  vnet            = module.network.vnet
  pg_password     = var.pg_password
}