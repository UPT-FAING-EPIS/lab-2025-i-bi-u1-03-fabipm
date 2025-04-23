terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Referenciamos el grupo de recursos ya existente
data "azurerm_resource_group" "example" {
  name = "recursosLab03"
}

# Referenciamos el servidor SQL ya existente
data "azurerm_mssql_server" "example" {
  name                = "serverlab03"
  resource_group_name = data.azurerm_resource_group.example.name
}

# Creamos la base de datos (si aún no existe)
resource "azurerm_mssql_database" "example" {
  name      = "bdlab03"
  server_id = data.azurerm_mssql_server.example.id
  sku_name  = "Basic"
}

# Creamos la regla de firewall (si aún no existe)
resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
  name             = "AllowMyIP"
  server_id        = data.azurerm_mssql_server.example.id
  start_ip_address = "38.250.158.150"
  end_ip_address   = "38.250.158.150"
}
