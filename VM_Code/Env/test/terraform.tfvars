resource_groups = {
  rg1 = {
    name     = "test-rg-1"
    location = "East US"
  }
 
}
virtual_networks = {
  vnet1 = {
    name                = "todo-vnet-1"
    location            = "East US"
    resource_group_name = "test-rg-1"
    address_space       = ["10.0.0.0/16"]
  }
}
subnets = {
  subnet1 = {
    name                 = "front-subnet-1"
    resource_group_name  = "test-rg-1"
    virtual_network_name = "todo-vnet-1"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "back-subnet-2"
    resource_group_name  = "test-rg-1"
    virtual_network_name = "todo-vnet-1"
    address_prefixes     = ["10.0.2.0/24"]  
 }
}
storage_accounts = {
  sa1 = {
    name                     = "testsa1923"
    resource_group_name      = "test-rg-1"
    location                 = "East US"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  
}
virtual_machines = {
  vm1 = {
    name                = "frontend-vm-1"
    resource_group_name = "test-rg-1"
    location            = "East US"
    size                = "Standard_B1s"
    admin_username      = "adminuser"
    admin_password      = "abc123!@#"
    
    os_image_publisher  = "Canonical"
    os_image_offer      = "UbuntuServer"
    os_image_sku        = "18.04-LTS"
    subnet_key          = "subnet1"
  }


}
  
 