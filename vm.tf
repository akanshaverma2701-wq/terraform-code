

resource "azurerm_resource_group" "rg" {
  for_each = var.varvm
  name     = each.value.rgname
  location = each.value.location
}

resource "azurerm_virtual_network" "vnet" {
  depends_on          = [azurerm_resource_group.rg]
  for_each            = var.varvm
  name                = each.value.vnet_name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = each.value.rgname
}

resource "azurerm_subnet" "subnet" {
  depends_on           = [azurerm_virtual_network.vnet]
  for_each             = var.varvm
  name                 = each.value.subnet_name
  resource_group_name  = each.value.rgname
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefix
}

resource "azurerm_public_ip" "pip" {
  depends_on          = [azurerm_resource_group.rg]
  for_each            = var.varvm
  name                = each.value.pip_name
  resource_group_name = each.value.rgname
  location            = each.value.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  depends_on          = [azurerm_resource_group.rg, azurerm_subnet.subnet]
  for_each            = var.varvm
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }
}


resource "azurerm_linux_virtual_machine" "main" {
  depends_on                      = [azurerm_subnet.subnet]
  for_each                        = var.varvm
  name                            = each.key
  resource_group_name             = each.value.rgname
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = "adminuser"
  admin_password                  = "Pass@12345678"
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}



