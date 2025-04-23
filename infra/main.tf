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

resource "azurerm_resource_group" "example" {
  name     = "recursosLab03"
  location = "westus2"
}

resource "azurerm_mssql_server" "example" {
  name                         = "serverlab03"
  location                     = azurerm_resource_group.example.location
  resource_group_name          = azurerm_resource_group.example.name
  version                      = "12.0"
  administrator_login          = "fabiola"
  administrator_login_password = "#050.Ada0"
}


resource "azurerm_mssql_database" "example" {
  name      = "bdlab03"
  server_id = azurerm_mssql_server.example.id
  sku_name  = "Basic"
  depends_on = [
    azurerm_mssql_server.example]
}


resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
  name                = "AllowMyIP"
  server_id           = azurerm_mssql_server.example.id
  start_ip_address    = "38.250.158.150"
  end_ip_address      = "38.250.158.150"
}