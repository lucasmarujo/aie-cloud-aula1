output "resource_group_name" {
  description = "Nome do Resource Group criado"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "Nome do Storage Account (globalmente único)"
  value       = azurerm_storage_account.sa.name
}

output "app_service_plan_name" {
  description = "Nome do App Service Plan (F1 Free)"
  value       = azurerm_service_plan.plan.name
}
