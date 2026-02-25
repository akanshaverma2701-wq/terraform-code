data "azurerm_subnet" "datasubnet" {
  depends_on           = [azurerm_resource_group.rg, azurerm_virtual_network.vnet, azurerm_subnet.subnet]
  for_each             = var.varvm
  name                 = each.value.subnet_name
  resource_group_name  = each.value.rgname
  virtual_network_name = each.value.vnet_name
}

data "azurerm_public_ip" "datapip" {
  depends_on          = [azurerm_resource_group.rg, azurerm_public_ip.pip]
  for_each            = var.varvm
  name                = each.value.pip_name
  resource_group_name = each.value.rgname
}