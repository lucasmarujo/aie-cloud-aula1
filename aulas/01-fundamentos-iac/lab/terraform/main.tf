terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
}

# Sufixo aleatório para garantir nomes únicos
# (Storage Accounts precisam ser globalmente únicos no Azure)
resource "random_string" "sufixo" {
  length  = 6
  upper   = false
  special = false
}

# Resource Group provisionado via Terraform (não pelo portal)
resource "azurerm_resource_group" "rg" {
  name     = "rg-iac-aula01-${random_string.sufixo.result}"
  location = var.location

  tags = {
    aula         = "1"
    disciplina   = "cloud-cognitive"
    provisionado = "terraform"
  }
}

# Storage Account — Standard LRS, free se ficar em poucos GBs
resource "azurerm_storage_account" "sa" {
  name                     = "stiac${random_string.sufixo.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = azurerm_resource_group.rg.tags
}

# App Service Plan F1 (Free) — base para hospedar uma futura web app
resource "azurerm_service_plan" "plan" {
  name                = "asp-iac-aula01-${random_string.sufixo.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "F1"

  tags = azurerm_resource_group.rg.tags
}
