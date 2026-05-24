# Exercícios — Aula 1

**Tema:** Fundamentos de Cloud & Infraestrutura como Código
**Formato:** Individual ou em dupla
**Entrega:** via fork no GitHub (ver [tutorial Git pós-aula](pos-aula-git.md)) até 1 dia antes da Aula 2

---

## Instruções gerais

Os exercícios estão divididos em três níveis. Você **não precisa fazer os três** — escolha o nível que faz mais sentido para o seu momento:

- 🟢 **Nível 1 — Básico:** Consolida os conceitos da aula. Recomendado para quem está começando na nuvem.
- 🟡 **Nível 2 — Intermediário:** Aprofunda com pesquisa e análise. Recomendado para quem já tem contato com cloud.
- 🔴 **Nível 3 — Avançado:** Envolve IaC e automação. Recomendado para quem já usa cloud no dia a dia.

Quem quiser o maior aproveitamento: tente completar o Nível 1 + pelo menos metade do Nível 2.

> **Política "no install":** Todos os exercícios podem ser feitos no Azure Cloud Shell + editor `code` (ou github.dev). Não instale nada localmente.

> **Conexão com o Projeto Final:** Os exercícios do Nível 2 e 3 já são blocos do Projeto Integrado Quantum Commerce. Guarde suas respostas — elas vão compor a entrega final.

---

## 🟢 Nível 1 — Básico: Consolidando os Fundamentos

### Exercício 1.1 — Mapeamento de modelos de serviço

Para cada serviço, identifique se é IaaS, PaaS, SaaS ou FaaS. Justifique em uma frase.

| Serviço | Modelo (IaaS/PaaS/SaaS/FaaS) | Justificativa |
|---------|------------------------------|---------------|
| Gmail | | |
| Azure Virtual Machines | | |
| Azure App Service (hospedar uma API) | | |
| AWS Lambda | | |
| Azure SQL Database | | |
| Salesforce CRM | | |
| Google Kubernetes Engine (GKE) | | |
| Azure Blob Storage | | |
| Azure OpenAI Service | | |

**Gabarito esperado:**

<details>
<summary>Clique para ver o gabarito</summary>

| Serviço | Modelo | Justificativa |
|---------|--------|---------------|
| Gmail | SaaS | Aplicação completa entregue ao usuário; você não gerencia nada da infra |
| Azure Virtual Machines | IaaS | Você gerencia SO, patches e aplicações; Azure só fornece hardware virtualizado |
| Azure App Service | PaaS | Azure gerencia SO e runtime; você só implanta o código |
| AWS Lambda | FaaS | Você escreve apenas a função; sem servidor fixo, paga por execução |
| Azure SQL Database | PaaS | Azure gerencia motor de banco; você gerencia dados e esquema |
| Salesforce CRM | SaaS | Aplicação completa entregue como serviço |
| GKE | PaaS/IaaS (híbrido) | Você gerencia os pods; GCP gerencia o plano de controle do K8s |
| Azure Blob Storage | PaaS (a maioria considera) | Storage gerenciado; você gerencia dados e políticas |
| Azure OpenAI Service | SaaS / API-as-a-Service | API pronta — você consome via REST sem gerenciar modelo ou infra |

</details>

---

### Exercício 1.2 — Os 6 Rs na prática

Leia cada cenário e escolha o R de migração mais adequado (Rehost, Replatform, Refactor, Repurchase, Retire, Retain). Justifique.

**Cenário A:** Empresa de logística tem sistema de rastreamento de frotas em servidor físico próprio. Código de 2008, sem documentação, só uma pessoa sabe mexer. Quer migrar rápido para ganhar elasticidade.

**Cenário B:** Banco regional usa ERP local de RH. Análise mostra: menos de 5 usuários ativos por mês, dados raramente consultados.

**Cenário C:** Fintech tem API de pagamentos monolítica. Decide aproveitar a migração para refatorar em microserviços com K8s e event-driven.

**Cenário D:** Varejo usa CRM desenvolvido internamente há 15 anos. SaaS de mercado atenderia 90% das necessidades por menor custo.

**Cenário E:** Instituição financeira tem mainframe com dados de clientes que precisa ficar on-premise por exigência do Banco Central.

---

### Exercício 1.3 — Calculando o impacto do SLA

Sistema de e-commerce com SLA de 99,9%.

a) Quantas horas de downtime por ano?
b) Se processa R$ 50.000/hora em vendas, qual o impacto financeiro máximo por ano?
c) Para reduzir o impacto para menos de R$ 50.000/ano, qual SLA mínimo seria necessário?

> **Fórmulas úteis:**
> Downtime anual (horas) = 8.760 × (1 - SLA/100)
> Downtime mensal (min) = 43.800 × (1 - SLA/100)

---

### Exercício 1.4 — RBAC na prática

Você é o responsável de segurança da Quantum Commerce. Para cada perfil abaixo, escolha a role built-in do Azure mais adequada e justifique:

| Perfil | Role Azure mais adequada | Justificativa |
|--------|--------------------------|---------------|
| Agente de IA que LÊ produtos do Storage para responder ao cliente | | |
| Engenheiro de dados que CARREGA novos catálogos no Blob | | |
| Time de FinOps que precisa VER custos sem alterar recursos | | |
| Auditor externo que precisa LER configurações de toda a assinatura | | |
| Sistema de CI/CD que provisiona infraestrutura via Terraform | | |

**Referência:** [Azure Built-in Roles](https://learn.microsoft.com/azure/role-based-access-control/built-in-roles)

<details>
<summary>Sugestões de gabarito (existem múltiplas respostas válidas)</summary>

- Agente que lê produtos: **Storage Blob Data Reader** (acesso só de leitura no plano de dados)
- Engenheiro de dados que carrega: **Storage Blob Data Contributor**
- FinOps: **Cost Management Reader** ou **Billing Reader**
- Auditor externo: **Reader** na assinatura
- CI/CD provisionando IaC: **Contributor** no Resource Group específico (não na assinatura) + Service Principal dedicado

**Princípio:** O menor privilégio possível para a tarefa. Nunca dar Owner ou Contributor da assinatura quando uma role escoped basta.

</details>

---

## 🟡 Nível 2 — Intermediário: Análise e Estratégia

### Exercício 2.1 — Arquitetura de alto nível: Quantum Commerce

**Contexto:** A Quantum Commerce é um gigante do e-commerce com 12 países, 5M de SKUs, e quer transformar a experiência de compra com IA conversacional.

**Sua tarefa (em grupo):** Proponha uma arquitetura de alto nível em cloud para a QC. Identifique:

1. **Camadas da arquitetura** — quantas e o que cada uma faz (ex: frontend, API, dados, AI/ML, observabilidade)
2. **Provedor principal** — qual escolheria (Azure, AWS, GCP) e por quê
3. **Serviços por categoria** — preencha a tabela:

| Categoria | Serviço Azure | Alternativa AWS | Alternativa GCP |
|-----------|--------------|-----------------|-----------------|
| Compute (backend) | | | |
| Storage (catálogo, imagens) | | | |
| Banco relacional | | | |
| Banco NoSQL | | | |
| Vector Database | | | |
| Serviços de IA cognitivos | | | |
| CDN | | | |
| Mensageria/Filas | | | |
| Observabilidade (logs/métricas) | | | |

4. **Diagrama** — feito no Excalidraw (excalidraw.com), draw.io (diagrams.net) ou à mão fotografado. **Tudo sem instalação.**

> **Entrega:** O grupo commita o esboço (`respostas-aula01.md` + imagem do diagrama) no fork até 1 dia antes da Aula 2. O professor dá feedback escrito durante a semana. O diagrama evolui a cada aula até a entrega final na Aula 6.

---

### Exercício 2.2 — Comparativo de custos: 3 provedores

Você precisa recomendar infraestrutura para um projeto de AI Engineering. Use as calculadoras para comparar:

- 2 VMs com 2 vCPUs e 8 GB RAM (Linux, 24/7)
- 500 GB de object storage
- 1 banco gerenciado com 2 vCPUs / 8 GB RAM / 100 GB
- 10 milhões de requisições/mês para função serverless

| Item | Azure | AWS | GCP | Notas |
|------|-------|-----|-----|-------|
| 2 × VM (2vCPU/8GB) | | | | Tipo: |
| 500 GB storage | | | | Tipo: |
| Banco gerenciado | | | | Tipo: |
| 10M req serverless | | | | Tipo: |
| **Total mensal** | | | | |
| **Total anual** | | | | |

**Análise:**

a) Qual provedor ficou mais barato? A diferença é significativa?
b) Aplicando Reserved Instances de 1 ano no mais caro, o resultado muda?
c) Além de preço, que outros fatores você consideraria para um projeto de IA?

**Calculadoras:**

- Azure: https://azure.microsoft.com/pricing/calculator
- AWS: https://calculator.aws
- GCP: https://cloud.google.com/products/calculator

---

### Exercício 2.3 — Estratégia de migração para sua empresa

Pense no seu contexto profissional atual (ou empresa que conhece bem).

a) Descreva um sistema/workload (sem dados confidenciais — pode ser genérico)
b) Qual dos 6 Rs você aplicaria? Justifique custo, risco, ganho, prazo
c) Que serviço Azure usaria? Estimativa mensal?
d) Maior obstáculo técnico ou organizacional? Como endereçaria?

---

## 🔴 Nível 3 — Avançado: IaC e Automação

### Exercício 3.1 — Terraform: estende o lab com Network Security

**Tudo no Cloud Shell — sem instalação.**

Partindo do `main.tf` do lab (Atividade 5), **estenda** com os seguintes recursos:

1. Uma **Virtual Network** (VNet) com endereçamento `10.10.0.0/16`
2. Uma **subnet** chamada `subnet-app` com `10.10.1.0/24`
3. Um **Network Security Group** (NSG) que permite apenas:
   - HTTP (porta 80) inbound de qualquer origem
   - HTTPS (porta 443) inbound de qualquer origem
   - SSH (porta 22) inbound APENAS do seu IP público (`curl ifconfig.me` no Cloud Shell para obter)
4. Associe o NSG à subnet

**Critérios:**

- `terraform plan` + `apply` rodam sem erro
- `terraform destroy` ao final remove tudo
- Código commitado no seu fork do repo da disciplina (via github.dev)

**Dica:** Documentação dos recursos:

- `azurerm_virtual_network`
- `azurerm_subnet`
- `azurerm_network_security_group`
- `azurerm_subnet_network_security_group_association`

---

### Exercício 3.2 — Bicep equivalente

Pegue o `main.tf` do lab + sua extensão do 3.1 e **traduza para Bicep**.

**Tudo no Cloud Shell — `bicep` já está instalado.**

1. Crie `main.bicep` em `~/aula01-bicep/`
2. Implemente os mesmos recursos (RG + Storage + App Service Plan F1 + VNet + Subnet + NSG)
3. Faça deploy com:

```bash
# Bicep precisa do RG já existente OU usar subscription scope
az group create --name rg-bicep-aula01 --location brazilsouth

az deployment group create \
  --resource-group rg-bicep-aula01 \
  --template-file main.bicep
```

4. Compare os arquivos lado a lado e responda no README do seu fork:
   - Quantas linhas tem cada arquivo?
   - Qual ficou mais legível para você?
   - Em que cenário você escolheria Bicep sobre Terraform?

5. **Não esqueça:** `az group delete --name rg-bicep-aula01 --yes --no-wait` ao final.

---

### Exercício 3.3 — Desafio de arquitetura: multi-cloud para a Quantum Commerce

**Contexto:** O CTO da QC quer evitar lock-in e pediu análise multi-cloud.

a) **Desenhe uma arquitetura multi-cloud** com pelo menos 2 provedores. Justifique por que cada workload em cada nuvem.

b) **Identifique 4 desafios principais**: latência entre nuvens, identidade unificada, custos de egress, observabilidade.

c) **Compare 2 ferramentas IaC multi-cloud:**
   - **Terraform** (HashiCorp) — https://www.terraform.io
   - **Pulumi** — https://www.pulumi.com

   Para cada: linguagem, pricing, suporte aos 3 grandes, quando escolher.

d) **Estime custo de egress:** 10 TB/mês entre Azure (Brazil South) e AWS (us-east-1). Consulte tabelas de preço e calcule.

> **Dica avançada:** Pesquise **Azure Arc** e **AWS Outposts** — como se encaixariam na QC?

---

## Critérios de entrega

| Nível | O que entregar | Como entregar |
|-------|---------------|---------------|
| Nível 1 | Respostas dos exercícios 1.1, 1.2, 1.3, 1.4 | Arquivo `respostas-aula01.md` no seu fork do repo via github.dev |
| Nível 2 | 2.1 (com diagrama), 2.2 (tabela), 2.3 | Adicionar ao mesmo arquivo + imagem do diagrama no repo |
| Nível 3 | Código Terraform/Bicep + README | Commits no repo + README explicando como rodar |

**Prazo:** 1 dia antes da Aula 2.
**Como entregar:** Fork do repositório da disciplina + commits via github.dev. Tutorial completo em [pos-aula-git.md](pos-aula-git.md).

---

## Gabarito parcial — Nível 1

### 1.2 — Os 6 Rs

<details>
<summary>Clique para ver as respostas</summary>

**Cenário A (sistema de 2008 sem doc):** **Rehost (Lift & Shift)** — migração rápida sem alterar código. Risco do único mantenedor + urgência justificam o caminho de menor esforço.

**Cenário B (ERP com 5 usuários/mês):** **Retire** — o custo de migrar provavelmente excede o valor gerado. Arquivar dados em storage frio e aposentar.

**Cenário C (API de pagamentos monolítica):** **Refactor** — decisão de reescrever em microserviços foi explícita. Alto esforço, maior ganho.

**Cenário D (CRM interno de 15 anos):** **Repurchase** — SaaS de mercado cobre 90% por menor custo. Decisão de negócio.

**Cenário E (mainframe por regulação BACEN):** **Retain** — compliance dita. Não é falha de estratégia.

</details>

### 1.3 — SLA e impacto

<details>
<summary>Clique para ver as respostas</summary>

**a)** 8.760 × (1 - 0,999) = **8,76 horas/ano** (~525 min)

**b)** 8,76 × R$ 50.000 = **R$ 438.000/ano**

**c)** Máx downtime = 50.000 ÷ 50.000 = 1h/ano → 1 ÷ 8.760 = 0,0114% → SLA mínimo **99,9886%** → na prática **SLA 99,99%** (52 min/ano)

</details>
