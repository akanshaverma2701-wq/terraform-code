
# resource "azurerm_resource_group" "rg" {
#   name     = "rg01"
#   location = "west us"
# }

# resource "azurerm_virtual_network" "vnet" {
#   depends_on          = [azurerm_resource_group.rg]
#   name                = "vnet01"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   address_space       = ["10.0.0.0/16"]
# }

# resource "azurerm_subnet" "subnet01" {
#   depends_on           = [azurerm_virtual_network.vnet]
#   name                 = "frontend"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

# resource "azurerm_subnet" "subnet02" {
#   depends_on           = [azurerm_virtual_network.vnet]
#   name                 = "backend"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

# resource "azurerm_network_interface" "nic1" {
#   depends_on          = [azurerm_subnet.subnet01]
#   name                = "frontendnic"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   ip_configuration {
#     name                          = "interna"
#     subnet_id                     = azurerm_subnet.subnet01.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_network_interface" "nic2" {
#   depends_on          = [azurerm_subnet.subnet01]
#   name                = "backendnic"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnet02.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "vm01" {
#   depends_on                      = [azurerm_subnet.subnet01]
#   name                            = "frontendvm"
#   location                        = azurerm_resource_group.rg.location
#   resource_group_name             = azurerm_resource_group.rg.name
#   size                            = "Standard_D2s_v3"
#   admin_username                  = "frontendvm"
#   admin_password                  = "Pass@12345678"
#   disable_password_authentication = false
#   network_interface_ids           = [azurerm_network_interface.nic1.id]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#   publisher = "Canonical"
#   offer     = "0001-com-ubuntu-server-jammy"
#   sku       = "22_04-lts-gen2"
#   version   = "latest"
# }
# }

# resource "azurerm_linux_virtual_machine" "vm02" {
#   depends_on                      = [azurerm_subnet.subnet02]
#   name                            = "backendvm"
#   location                        = azurerm_resource_group.rg.location
#   resource_group_name             = azurerm_resource_group.rg.name
#   size                            = "Standard_D2s_v3"
#   admin_username                  = "backendvm"
#   admin_password                  = "Pass@12345678"
#   disable_password_authentication = false
#   network_interface_ids           = [azurerm_network_interface.nic2.id]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#   publisher = "Canonical"
#   offer     = "0001-com-ubuntu-server-jammy"
#   sku       = "22_04-lts-gen2"
#   version   = "latest"
# }
# }



