# Informações gerais sobre o Terraform | Material de Apoio

**A ideia do Terraform é nos ajudar a provisionar a infraestrutura,** criando e gerenciando por meio de código, muito conhecido também como **IaaC** (Infrastructure as a Code).

A Ferramenta Terraform **não está presa a nenhum provedor de cloud** (AWS, Azure, GCP). É multiplataforma.

Para usar a ferramenta é necessário apenas **baixar** o Terraform.

- O Terraform é apenas um executável.
- No Linux é apenas usar o ./terraform ou definir o path dele para inicializar automaticamente.

- A **Sintaxe do Terraform é a HCL (HashiCorp Configuration Language).**
- **A extensão do Terraform é o .tf e .tfvars**
- Você pode usar qualquer editor de texto que preferir, até mesmo o bloco de notas do Windows.
- Não precisa compilar o código.
- Funciona em Windows, Linux, Mac, Solaris, etc

Se você tem uma infra no código, você vai otimizar muito o seu tempo em provisionar ambientes.

**VANTAGENS DE USAR O TERRAFORM COMO IaaC**

- Automatizar um provisionamento de infraestrutura;
- Mudar, Atualizar, Deletar, Recriar uma infraestrutura;
- Clonar ambientes de infraestrutura;
- Validar mudanças antes de colocar em produção;
- Crescer rapidamente o seu ambiente;
- Reusar o código para projetos similares e reduzir o custo de desenvolvimento;
- Melhorar a colaboração do time de DevOps.


## Dentro da ferramenta
**Atualizar o Terraform**

`terraform version` → Checa a versão do Terraform

- Baixar diretamente do site;
- Unzipar;
- Mover o arquivo terraform para onde ele estava anteriormente.

**Passos para o Deploy**
1. Baixa as dependências.
```bash
$ terraform init
```
2. Mostra como vai ficar o ambiente (planeja).
```bash
$ terraform plan
```
3. Pega o planejamento e joga para a plataforma que receberá o deploy, efetivando assim as mudanças. Esse passo exige uma confirmação.
```bash
$ terraform apply
```
