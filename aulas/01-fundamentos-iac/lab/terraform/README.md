# Terraform — Aula 1, Atividade 5

Código pronto da Atividade 5 do laboratório. Provisiona Resource Group + Storage Account + App Service Plan F1 (free) no Azure.

## Como usar (no Azure Cloud Shell)

```bash
# Clonar o repositório (apenas na primeira vez)
git clone https://github.com/elthonf/aie-cloud.git
cd aie-cloud/aulas/01-fundamentos-iac/lab/terraform

# Inicializar providers
terraform init

# Ver o que será criado
terraform plan

# Aplicar (digite 'yes' quando perguntar)
terraform apply

# ... usar os recursos / fazer experiência ...

# Destruir TUDO ao final (regra de ouro — custo zero)
terraform destroy
```

## Arquivos

| Arquivo | O que contém |
|---------|--------------|
| [main.tf](main.tf) | Providers + recursos (RG, Storage Account, App Service Plan) |
| [variables.tf](variables.tf) | Variáveis de entrada (região) |
| [outputs.tf](outputs.tf) | Saídas após `apply` (nomes dos recursos) |

## Observações

- **Nomes únicos:** o `random_string.sufixo` garante que o Storage Account (que precisa de nome globalmente único no Azure) não colida com o de outro aluno.
- **Idempotência:** rode `terraform apply` duas vezes — na segunda, o Terraform detecta que nada mudou e não recria nada.
- **Estado:** o arquivo `terraform.tfstate` é gerado localmente. Em projetos reais, ele vai para um remote backend (Azure Storage, S3, Terraform Cloud).

## Conexão com o Quantum Commerce

Este `main.tf` é o **embrião da infraestrutura QC**. Nas próximas aulas, ele evolui:

```
aula01/  RG + Storage + App Service Plan
aula02/  + Storage Containers + Azure SQL + Cosmos DB + AI Search
aula03/  + Azure Functions + Container Instances
aula04/  + Azure AI Services (Speech, Vision, Language)
aula05/  + Azure ML Workspace + MLflow
aula06/  + análise FinOps de tudo
```
