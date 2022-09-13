provider "aws" {
  region = "eu-north-1"
}

data "aws_availability_zones" "available" {}

# Na criação do Bucket é importante ativar o versionamento e é importante ser encriptado.

terraform {
  backend "s3" { // Configurando o s3 no backend
    bucket = "adv-it-terraform-remote-state" // Bucket onde iremos SALVAR o nosso estado do Terraform
    key    = "dev/network/terraform.tfstate" // Nome do objeto no bucket para SALVAR o estado do Terraform
    region = "us-west-2"                     // Região do bucket
  }
}


resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr // Variável do arquivo variables
  tags = {
    Name  = "${var.env}-vpc" // variables.tf
    Owner = "Amadeus Amorim"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name  = "${var.env}-igw"
    Owner = "Amadeus Amorim"
  }
}


resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name  = "${var.env}-public-${count.index + 1}"
    Owner = "Amadeus Amorim"
  }
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name  = "${var.env}-route-public-subnets"
    Owner = "Amadeus Amorim"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}