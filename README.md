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


## Dentro da ferramenta

### ATUALIZAR O TERRAFORM
`terraform version` → Checa a versão do Terraform

- Baixar diretamente do site;
- Unzipar;
- Mover o arquivo terraform para onde ele estava anteriormente.

### PASSOS PARA O DEPLOY
1. Baixa as dependências.
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
7. Faz o reload do código.
```bash
$ terraform refresh
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

### DICAS E SUGESTOÕES
- Utilize o código sempre quebrando a infra em arquivos diferentes.
- Os recursos principais, como instâncias, blobs/buckets, um database, é ideal que se coloque no arquivo main.tf.
- Recursos separados, tal como SG, variáveis, etc, é ideal que se separe em outros arquivos. 
- Utilizar o `depends_on` para organizar a infra, provisionando os recursos em ordem de prioridade.
- A recomendação é que tenhamos sempre os arquivos `main.tf`, `vars.tf` e `outputs.tf`.
