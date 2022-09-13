# Outro VPC de produção
provider "aws" {
  region = "eu-north-1"
}

module "vpc_prod" {
  # source             = "../modules/aws_network"
  source               = "git@github.com:adv4000/terraform_certified_modules.git//aws_network"
  env                  = "prod"
  vpc_cidr             = "10.200.0.0/16"
  public_subnet_cidrs  = ["10.200.1.0/24", "10.200.2.0/24", "10.200.3.0/24"] // Criando três subnets para uma alta disponibilidade
  private_subnet_cidrs = ["10.200.11.0/24", "10.200.22.0/24", "10.200.33.0/24"]
  tags = {
    Owner   = "ASTAHOV.NET"
    Code    = "777766"
    Project = "SuperPreject"
  }
}

module "server_standalone" { // Standalone porque é apenas um servidor numa Zona de Disponibilidade
  source = "../modules/aws_testserver"
  # source  = "git@github.com:adv4000/terraform_certified_modules.git//aws_testserver"  # <-- Adiciona na branch padrão
  # source  = "git@github.com:adv4000/terraform_certified_modules.git//aws_testserver?ref=yourbranchname" # <-- Você seleciona a branch utilizada no ref=
  name      = "ADV-IT"
  message   = "Stand Alone Server"
  subnet_id = module.vpc_prod.public_subnet_ids[2] // Escolho o terceiro módulo da minha lista de subnets públicas
}

module "servers_loop_count" {
  source = "../modules/aws_testserver"
  # source    = "git@github.com:adv4000/terraform_certified_modules.git//aws_testserver"
  count     = length(module.vpc_prod.public_subnet_ids) // Quantos servidores eu vou querer? Faço o len da lista de subnets públicos
  name      = "ADV-IT"
  message   = "Hello From server in Subnet ${module.vpc_prod.public_subnet_ids[count.index]} created by COUNT Loop"
  subnet_id = module.vpc_prod.public_subnet_ids[count.index]
}

module "servers_loop_foreach" {
  source = "../modules/aws_testserver"
  # source     = "git@github.com:adv4000/terraform_certified_modules.git//aws_testserver"
  for_each   = toset(module.vpc_prod.public_subnet_ids)
  name       = "ADV-IT"
  message    = "Hello From server in Subnet ${each.value} created by FOR_EACH Loop"
  subnet_id  = each.value
  depends_on = [module.servers_loop_count] // Vai ser criado apenas após o server_loop_count
}