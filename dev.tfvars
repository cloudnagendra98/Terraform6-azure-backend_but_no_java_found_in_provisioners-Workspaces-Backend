vnet_network_cidr = ["10.0.0.0/16"]
subnet_cidr_range = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
subnet_names      = ["web", "app", "db"]
webnsg_config = {
  name = "webnsg"
  rules = [{
    name                       = "openhttp"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = "300"
    direction                  = "Inbound"
    },
    {
      name                       = "openssh"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = "310"
      direction                  = "Inbound"
  }]
}

appnsg_config = {
  name = "appnsg"
  rules = [{
    name                       = "open8080"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = "300"
    direction                  = "Inbound"
    },
    {
      name                       = "openssh"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = "310"
      direction                  = "Inbound"
  }]
}

dbnsg_config = {
  name = "dbnsg"
  rules = [{
    name                       = "open3306"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = "300"
    direction                  = "Inbound"
    },
    {
      name                       = "openssh"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = "310"
      direction                  = "Inbound"
  }]
}

db_info = {
  db_name        = "employer"
  server_name    = "ntierserver"
  server_version = "12.0"
  user_name      = "Dell"
  password       = "my@india@123"
  max_size_gb    = "2"
  sku_name       = "Basic"
}

appvm_config = {
  app_subnet_name               = "app"
  allocation_method             = "Static"
  public_ip_name                = "publicip"
  network_interface_name        = "ntier_nifc"
  ip_name                       = "nifc_ip"
  private_ip_address_allocation = "Dynamic"
  appvm_name                    = "appvm"
  username                      = "Dell"
  size                          = "Standard_B1s"
  public_key_path               = "~/.ssh/id_rsa.pub"
  private_key_path              = "~/.ssh/id_rsa"
  publisher                     = "Canonical"
  offer                         = "0001-com-ubuntu-server-jammy"
  sku                           = "22_04-lts-gen2"
  version                       = "latest"
}

