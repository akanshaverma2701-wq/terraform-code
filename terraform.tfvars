
varvm = {

  vm01 = {
    rgname         = "rg01"
    location       = "westus"
    vnet_name      = "vnet01"
    address_space  = ["10.0.0.0/16"]
    subnet_name    = "subnet01"
    address_prefix = ["10.0.1.0/24"]
    pip_name       = "pip1"
    nic_name       = "nic1"
    size           = "Standard_D2s_v3"
  }
  vm02 = {
    rgname         = "rg02"
    location       = "westus"
    vnet_name      = "vnet02"
    address_space  = ["10.0.0.0/16"]
    subnet_name    = "subnet02"
    address_prefix = ["10.0.2.0/24"]
    pip_name       = "pip2"
    nic_name       = "nic2"
    size           = "Standard_D2s_v3"
  }

}