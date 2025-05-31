resource "azurerm_public_ip" "public_ip" {
    for_each = var.virtual_machines
    name                = "${each.value.name}-public-ip"
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    allocation_method   = "Static"
    sku                 = "Basic"
  
}
resource "azurerm_network_interface" "nic" {
    for_each = var.virtual_machines
    name                = "${each.value.name}-nic"
    location            = each.value.location
    resource_group_name = each.value.resource_group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = var.subnet_ids[each.value.subnet_key]
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
    }
}
resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.virtual_machines
    name                = each.value.name
    resource_group_name = each.value.resource_group_name
    location            = each.value.location
    size                = each.value.size
    admin_username      = each.value.admin_username
    admin_password      = each.value.admin_password
    network_interface_ids = [azurerm_network_interface.nic[each.key].id]
    disable_password_authentication = false

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = each.value.os_image_publisher
        offer     = each.value.os_image_offer
        sku       = each.value.os_image_sku
        version   = "latest"
    }


custom_data = local.custom_data  # <---- Add this here

    
}
 

 locals {
  custom_html = file("${path.module}/../../my-site/index.html")
  encoded_html = base64encode(local.custom_html)

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "${local.encoded_html}" | base64 --decode > /var/www/html/index.html
EOF
  )
}


