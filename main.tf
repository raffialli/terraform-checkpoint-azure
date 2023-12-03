# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "VT" {
  name     = "VT-resources"
  location = "eastus"
}

# Create a virtual network
resource "azurerm_virtual_network" "VT" {
  name                = "VT-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.VT.location
  resource_group_name = azurerm_resource_group.VT.name
}

# Create a subnet
resource "azurerm_subnet" "VT" {
  name                 = "VT-subnet"
  resource_group_name  = azurerm_resource_group.VT.name
  virtual_network_name = azurerm_virtual_network.VT.name
  address_prefixes     = ["10.0.2.0/24"]
}
# Create a public IP address resource
resource "azurerm_public_ip" "VT_public_ip" {
  name                = "VT-publicip"
  location            = azurerm_resource_group.VT.location
  resource_group_name = azurerm_resource_group.VT.name
  allocation_method   = "Static"  // or "Static"
}

resource "azurerm_network_interface" "VT" {
  name                = "VT-nic"
  location            = azurerm_resource_group.VT.location
  resource_group_name = azurerm_resource_group.VT.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.VT.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.VT_public_ip.id
    // Add other required fields...
  }
}

# Deploy Check Point Firewall
resource "azurerm_virtual_machine" "checkpoint_fw" {
  name                  = "checkpoint-fw"
  location              = azurerm_resource_group.VT.location
  resource_group_name   = azurerm_resource_group.VT.name
  network_interface_ids = [azurerm_network_interface.VT.id]
  vm_size               = "Standard_F4"

  # Specify Check Point image
  storage_image_reference {
    publisher = "checkpoint"
    offer     = "check-point-cg-r8110"
    sku       = "sg-byol"
    version   = "latest"
  }

  # Plan information required for VMs created from Marketplace images
  plan {
    name      = "sg-byol"
    publisher = "checkpoint"
    product   = "check-point-cg-r8110"
  }

  storage_os_disk {
    name              = "R81dot10myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "checkpointfw"
    admin_username = "adminuser"
    admin_password = "Password123!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
