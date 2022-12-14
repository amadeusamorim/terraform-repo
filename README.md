# Terraform Overview | Material de Apoio

<p align="center">
    <br/>
    <a href="https://freeimage.host/br">	
        <img src="https://iili.io/47sDe1.jpg" alt="Terraform Overview">
    </a>
</p>


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
- Exitem três edições do Terraform:
  - Terraform CLI Open Source (terraform.exe)
  - Terraform Cloud (https://app.terraform.io)
  - Terraform Cloud Enterprise (Self-hosted distribution of Terraform Cloud)
    - Terraform Enterprise dispõe de tudo do cloud com o aditivo das Sentinels Policies e etc.

Se você tem uma infra no código, você vai otimizar muito o seu tempo em provisionar ambientes.

### VANTAGENS DE USAR O TERRAFORM COMO IaaC

- Automatizar um provisionamento de infraestrutura;
- Mudar, Atualizar, Deletar, Recriar uma infraestrutura;
- Clonar ambientes de infraestrutura;
- Validar mudanças antes de colocar em produção;
- Crescer rapidamente o seu ambiente;
- Reusar o código para projetos similares e reduzir o custo de desenvolvimento;
- Melhorar a colaboração do time de DevOps
- Se os arquivos estiverem no mesmo diretório, o Terraform entende que os arquivos se comunicam.

## Pré-código
Antes de colocarmos a mão na massa e escrevermos nossos códigos é necessário seguir alguns pontos, nos quais são elencados abaixo:
- Para utilizar o Terraform no seu ambiente local é necessário adicionar um usuário na sua cloud escolhida e concender permissões de Administrador para o Terraform.
- É recomendável você exportar para seu ambiente via CLI as credenciais: Access Key ID, Secret Acess Key ID e Região padrão (não mandatório).
```bash
# Exemplo AWS e Linux
$ export AWS_ACESS_KEY_ID='CHAVE AWS'
$ export AWS_SECRET_ACESS_KEY='SECRET ACESS KEY'
```
```powershell
# Exemplo AWS e Windows
$env:AWS_ACESS_KEY_ID='CHAVE AWS'
$env:AWS_SECRET_ACESS_KEY='SECRET ACESS KEY'
```

## Dentro da ferramenta

### ATUALIZAR O TERRAFORM
`terraform version` → Checa a versão do Terraform

- Baixar diretamente do site;
- Unzipar;
- Mover o arquivo terraform para onde ele estava anteriormente.

### PASSOS PARA O DEPLOY
1. Baixa as dependências para a sua pasta do Terraform. É recomendável usar o `.gitignore` para a pasta das dependências. 
```bash
$ terraform init
```
2. Mostra como vai ficar o ambiente (planeja). Também pode ser usado independente, para fins de verificar que mudançar irão ser aplicadas.
```bash
$ terraform plan
```
3. Pega o planejamento e joga para a plataforma que receberá o deploy, efetivando assim as mudanças. Esse passo exige uma confirmação. Pode ser usado sem o `plan`, porém não é recomendável.
```bash
$ terraform apply
```
 * É possível utilizar o `terraform apply -var="nomevar=valorvar"` para repassar uma variável da cli

4. Mostra uma _foto_ de como está seu ambiente naquele momento.
```bash
$ terraform show
```
5. Destrói o recurso passado como parâmetro, por exemplo: a máquina dev4. (Quando destruímos uma dependência, destruímos os recursos que dependem dela)
   1. Ao destruir via comando, ainda se faz necessário deletar o código dentro do script do Terraform.
```bash
$ terraform destroy -target aws.instance.dev4
```
6. Acaba com toda a infra.
```bash
$ terraform destroy
```
7. Faz o reload do código. Checa o que está no seu state file e no que está deploy. Se tiver algum gap, ele atualiza o statefile.
```bash
$ terraform refresh
```
8. Recupera o código destruído (se ele ainda constar no script). Importante usar depois de `terraform init` e antes de `terraform plan` e `terraform apply`.
```bash
$ terraform taint instance
```
9. Checa todo o seu código e retorna erros de resultados não declarados. Se o código estiver ok ele informa que a configuração está válida.
```bash
$ terraform validate
```
10. Printa apenas o que temos no nosso output.
```bash
$ terraform output
```
11. Printa toda a configuração e os valores default.
```bash
$ terraform show
```
12. Você entra dentro do console do terraform. Dá para printar nomes com upper, lower, codificar, passar listas, etc.
```bash
$ terraform console
```


### DENTRO DO CÓDIGO
- Para utilizarmos as dependências entre os recursos, é necessário o `depends_on`. Dentro do código ele vincula recursos, desta forma a criação/exclusão de um implica respectivamente no outro.
- Na criação de variáveis, consideramos os tipos:
  - O tipo map utiliza { } em sua declaração e contém chaves e valores.
  - O tipo list utiliza [ ] em sua declaração.
  - O tipo string não precisa ser declarado, pois o Terraform subtende.
- Ao apagar um recurso do código, o Terraform entende que é para destruí-lo.
  - Também é possível comentar o código para o Terraform destruí-lo.
  - Também pode ser feito via comando, como repassado na seção anterior.

### IMPORTANDO RECURSOS EXISTENTES
1. Você precisa ter recursos existentes.
2. Precisa começar a escrever o seu código no Terraform, criando a instância.
3. Depois é necessário dar o `terraform init` e em seguida `terraform import provedor_instancia.nome_instancia instance ID do provedor`

### TERRAFORM WORKSPACE
- Workspace no Terraform é uma feature que permite você duplicar/clonar recursos com a mesma configuração, sem alteração.
- Ideal é apenas para ser usados em TESTES.
- Inclue 5 diferentes comandos
- `terraform workspace show` -> Mostra o Workspace que você está trabalhando agora.
- `terraform workspace list` -> Mostra todos os Workspaces que você tem agora e aponta para qual deles você se encontra.
- `terraform workspace new` -> Após o new, passa o nome do novo Workspace a ser criado, após o comando, é criado um novo workspace e alterado para lá (switched).
  - Ainda que você dê `terraform deploy` agora, nada vai acontecer, muitos dos recursos não podem ter deploy com o mesmo nome.
- `terraform workspace select` -> Após o select você coloca o nome do workspace que você quer trocar e utilizar dos existentes.
- `terraform workspace delete` -> Após o delete você coloca o nome do workspace que você quer deletar, após os testes realizados. 
  - Não pode deletar um workspace que você está usando no momento.
  - Se você fez deploy com um workspace, primeiro você tem que dar um `terraform deploy`, antes do `workspace delete`.

### REFATORANDO O CÓDIGO TERRAFORM
- O Refatoramento do código do seu Terraform ajuda a manter o ambiente organizado e que as alterações futuras não demorem muito.
- É normal em grandes ambientes, caso não esteja refatorado, uma pasta só conter mais de 800 arquivos de configuração da sua infra.
- Alguns códigos são necessários para a organização, são:
- `terraform state show recurso.nome` -> Mostra as configurações de um recurso específico. (É um comando seguro, ou seja, nada acontece se você der enter).
- `terraform state list` -> Mostra todos os recursos que existem no arquivo state. Mostra o recurso e qual o seu nome em uma lista. (É um comando seguro, ou seja, nada acontece se você der enter).
- `terraform state pull` -> Coloca o arquivo state na sua tela. Vai mostrar em .json todo o escopo da sua infraestrutura da pasta. (É um comando seguro, ou seja, nada acontece se você der enter).
  - Posso direcionar meu `pull` para um arquivo por meio do comando bash, usando > e destinando um file. Dessa forma fica mais fácil de trabalhar em alterações na infra.
- `terraform state rm` -> Remove os resultados do state completamente. Remove o recurso do Terraform. (É um comando perigoso, importante checar novamente antes de dar enter).
- `terraform state mv` -> Move um recurso dentro de um state de um lugar para outro. (É um comando perigoso, importante checar novamente antes de dar enter).
  - Posso usar também para renomear um state, usando por exemplo: `terraform state mv aws_epi.prodd aws_eip.prod`, o arquivo passará a ter o nome terminado em prod.
  - `terraform state mv -state-out="terraform.tfstate" aws_eip.prod aws_eip.prod` -> Extraio o meu arquivo para o .tfstate. É sempre guardado um backup do meu .tfstate.

- `terraform state push` -> Sobrescreve um arquivo state. (É um comando perigoso, importante checar novamente antes de dar enter).


### DICAS E SUGESTÕES

- Utilize o código sempre quebrando a infra em arquivos diferentes.
- Os recursos principais, como instâncias, blobs/buckets, um database, é ideal que se coloque no arquivo main.tf.
- Recursos separados, tal como SG, variáveis, etc, é ideal que se separe em outros arquivos. 
- Utilizar o `depends_on` para organizar a infra, provisionando os recursos em ordem de prioridade.
- A recomendação é que tenhamos sempre os arquivos `main.tf`, `vars.tf` e `outputs.tf`.
- É importante usar sempre o modo remote para um melhor segurança do código.
- No Backend é possível trabalhar de modo local e remoto.
- É importante, quando a equipe for muito grande, usar o Terraform Cloud, pois várias pessoas podem mexer no código simultaneamente. Para isso é necessário:
  - Necessário criar uma conta na nuvem (site da Hashicorp).
    - Criar uma 'Nova organização'
    - Dentro da organização eu vou ter as configs da minha infra (histórico e setups).
    - Gerar um token dentro das configurações para criar o acesso remoto do seu arquivo local. (Token só aparece uma vez)
  - Criar um arquivo de configuração na home do seu usuário local.
  - Usar as configs do `.terraformrc` passando a API como parâmetro, ver config-file aqui: https://www.terraform.io/cli/config/config-file
  - O arquivo `.terraformrc` tem os seguintes requisitos: conter o token de acesso e ficar na home do usuário.
- Recomendável usar layers para cada departamento, DevOps, Engenheria, SRE, etc, trabalhar em uma diferente.
- Após subir o ambiente para o remote teremos controle de versionamento.
- Terraform Cloud é grauito, mas tem features pagas, como o Sentinel Policies.
- É possível ter um custo estimado.
- É importante olhar na documentação o que pode ou não ser printado em output em "Attributes Reference".
- É possível passar variáveis pela CLI (Ver em terraform apply nesse doc).
- É possível exportar uma variável para o ambiente `TF_VAR_nomevar="valorvar"`.
- Importante ver na documentação a ordem de precedência das variáveis.
- O parâmetro `-auto-approve` evita confirmações na execução de um comando.