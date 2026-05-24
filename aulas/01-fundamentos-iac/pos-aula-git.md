# Pós-Aula 1 — Git e GitHub sem instalar nada

**Tempo estimado:** ~20 min
**Quando fazer:** Entre a Aula 1 e a Aula 2 (até 1 dia antes da Aula 2)

---

## Por que esta tarefa existe

A partir da Aula 2, vamos entregar exercícios e código (Terraform, Python) via GitHub. Esta tarefa garante que você consiga:

1. Criar uma conta GitHub
2. Fazer fork do repositório da disciplina (sem comandos `git clone` na sua máquina)
3. Editar arquivos diretamente no browser usando `github.dev`
4. Fazer commits sem instalar Git localmente

> **Política "no install":** Nada é instalado no seu computador. Tudo é via browser ou Cloud Shell.

---

## Pré-requisitos

- E-mail pessoal (Gmail, Outlook etc.) — **não use o e-mail FIAP**, ele pode ter restrições corporativas no GitHub
- Navegador moderno

---

## Parte 1 — Criar conta GitHub (5 min)

Se você já tem conta GitHub, **pule para a Parte 2**.

1. Acesse: **https://github.com/signup**
2. Use seu **e-mail pessoal**
3. Escolha uma senha forte e um username (sugestão: `seu-nome` ou `seu-nome-fiap` para identificação)
4. Complete o captcha
5. Confirme o e-mail (link enviado para sua caixa)
6. Na pesquisa "What's your role?" → estudante (Student)
7. Escolha o plano **Free**
8. Pronto. Você tem conta GitHub.

---

## Parte 2 — (Opcional) Ativar GitHub Student Developer Pack

GitHub oferece um pacote gratuito para estudantes com benefícios extras (Codespaces estendido, créditos em ferramentas).

1. Acesse: **https://education.github.com/pack**
2. Clique em **"Get your pack"**
3. Faça login com sua conta GitHub
4. Verifique status acadêmico:
   - Documento sugerido: comprovante de matrícula FIAP em PDF
   - Ou e-mail institucional `@fiap.com.br` (se você adicioná-lo como secundário à conta)
5. Aguarde aprovação (geralmente 1-3 dias)

> **Não é bloqueante** para a disciplina — mas dá Codespaces estendido e outros benefícios que ajudam na Aula 3 em diante.

---

## Parte 3 — Fork do repositório da disciplina (3 min)

O repositório oficial da disciplina é:

**https://github.com/elthonf/aie-cloud**

1. Acesse o link do repositório
2. No canto superior direito, clique em **"Fork"** (ícone de bifurcação)
3. Configure:
   - Owner: sua conta GitHub
   - Repository name: `aie-cloud` (manter padrão)
   - Description: opcional
   - Marque "Copy the **main** branch only"
4. Clique em **"Create fork"**

Em ~10 segundos, você tem uma cópia do repositório na sua conta. Você vai trabalhar nessa cópia (fork) e versionar suas entregas lá.

---

## Parte 4 — Editar arquivos via `github.dev` (5 min)

`github.dev` é uma versão do VS Code que roda no browser — **sem instalar nada**.

### Acessar

1. Vá para seu fork no GitHub: `https://github.com/seu-usuario/aie-cloud`
2. **Pressione a tecla `.`** (ponto) no teclado enquanto o repositório está aberto

Mágica: a URL muda para `github.dev` e abre um editor estilo VS Code com seu repositório carregado. Sem instalação. Sem clone local.

### Alternativa

Se preferir clicar: na URL do repositório, troque `github.com` por `github.dev`:

```
https://github.com/seu-usuario/aie-cloud
                ↓
https://github.dev/seu-usuario/aie-cloud
```

### Primeira edição

1. No editor `github.dev`, crie o arquivo `respostas-aula01.md` na raiz do repo
2. Adicione o seguinte conteúdo (substitua com suas informações):

```markdown
# Respostas — Aula 1

**Aluno(a):** Seu Nome

## Exercício 1.1 — Modelos de Serviço
(suas respostas aqui)
```

3. Salve o arquivo: `Ctrl+S` (Windows/Linux) ou `Cmd+S` (Mac)

### Commit das mudanças

1. No menu lateral esquerdo, clique no ícone de **Source Control** (símbolo de bifurcação, terceiro de cima)
2. Você vê o arquivo modificado na seção "Changes"
3. No campo de mensagem, escreva: `feat: respostas Aula 1`
4. Clique em **"Commit & Push"** (ou Commit + Sync)
5. Pronto — sua mudança está no GitHub

### Confirmar no browser

1. Volte para `https://github.com/seu-usuario/aie-cloud`
2. Você verá o arquivo `respostas-aula01.md` listado
3. Clique nele para ver o conteúdo

---

## Parte 5 — (Opcional) Git via Cloud Shell

Se você prefere usar a linha de comando, o Cloud Shell também tem `git` pronto.

### Configurar identidade (primeira vez)

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu.email.pessoal@gmail.com"
```

### Clonar o fork no Cloud Shell

```bash
cd ~
git clone https://github.com/seu-usuario/aie-cloud.git
cd aie-cloud
ls
```

### Fluxo básico

```bash
# Editar arquivo
code respostas-aula01.md

# Ver o que mudou
git status
git diff

# Commit
git add respostas-aula01.md
git commit -m "feat: respostas Aula 1"

# Enviar para o GitHub — vai pedir usuário e Personal Access Token
git push origin main
```

### Personal Access Token (para `git push` via Cloud Shell)

Como o GitHub não aceita mais senha em push HTTPS:

1. No GitHub, vá em: Settings → Developer settings → Personal access tokens → **Fine-grained tokens** → **Generate new token**
2. Nome: `cloud-shell-fiap`
3. Expiração: 90 dias
4. Repository access: Only select repositories → seu fork
5. Permissions: **Repository permissions** → **Contents: Read and write**
6. Generate token → **copie e guarde** (não verá de novo)
7. No `git push`, use seu username GitHub e cole o token como senha

> **Mais simples:** Use `github.dev` que não precisa de token.

---

## Como você vai entregar os exercícios

A partir da Aula 2, o fluxo será:

1. Resolver os exercícios em `respostas-aulaXX.md` no seu fork
2. Para exercícios de código (Terraform/Python), criar pastas tipo `aula02/terraform/` no seu fork
3. Commit + push até 1 dia antes da próxima aula
4. Avisar no chat com o link do seu fork

---

## Conexão com a Aula 2

Na Aula 2, vamos:

- Criar storage via Terraform (`storage.tf`) — você vai versionar isso no fork
- Popular dados via Python — também versionado
- Continuar evoluindo o esboço da arquitetura QC do seu grupo

Ter o GitHub funcionando hoje evita que a Aula 2 vire tutorial de Git.

---

## Troubleshooting

| Problema | Solução |
|----------|---------|
| "Fork" botão não aparece | Você não está logado no GitHub. Faça login primeiro. |
| `github.dev` não abre quando pressiono `.` | Garanta que está na página do repositório (não na visualização de um arquivo). Tente trocar a URL manualmente. |
| `git push` no Cloud Shell pede senha e falha | Use Personal Access Token, não senha. Veja Parte 5. |
| Não recebi link do repo da disciplina | O repo é público: https://github.com/elthonf/aie-cloud |

---

## Confirmação

Ao final, você deve ter:

- ✅ Conta GitHub criada
- ✅ Fork do repo da disciplina criado
- ✅ `respostas-aula01.md` editado e commitado via `github.dev`
- ✅ Capacidade de editar arquivos sem instalar nada

**Próxima parada:** Aula 2 — Storage & Bancos de Dados na Quantum Commerce.
