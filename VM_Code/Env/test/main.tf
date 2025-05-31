module "resource_group" {
  source = "../../Modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}
module "storage_account" {
  source = "../../Modules/azurerm_storage_account"
  storage_accounts = var.storage_accounts
  depends_on = [ module.resource_group ]
}
module "virtual_network" {
  source = "../../Modules/azurerm_virtual_network"
  virtual_networks = var.virtual_networks
  depends_on = [ module.resource_group ]
}
module "subnet" {
  source = "../../Modules/azurerm_subnet"
  subnets = var.subnets
  depends_on = [ module.virtual_network ]
}
module "virtual_machine" {
  source = "../../Modules/azurerm_virtual_machine"
  virtual_machines = var.virtual_machines
  subnet_ids = module.subnet.subnet_ids
    depends_on = [ module.resource_group, module.storage_account, module.virtual_network, module.subnet ]
}