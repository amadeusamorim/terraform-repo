#-------------------
# LAB 1
#-------------------

# Quando identificamos qual provider utilizaremos o Terraform baixa os binaries da cloud
provider "aws" {
    region = "us-west-2"
    // Tente nunca escrever suas credenciais no código, exporte para o Windows ou Linux, por segurança
    # access_key = "ACESS KEY HERE"
    # secret_key = "SECRET KEY HERE"
}

resource "aws_instance" "my_pc" {
  ami           = "ami ID no console da AWS - define a imagem"
  // Se eu mudar a minha imagem para uma t3.micro, o Terraform vai pausar minha VM, trocar o tipo de instância e depois executar novamente
  instance_type = "t3.micro"
  // Adicionando uma key name para acessar minha imagem
  key_name = "amadeus-key-oregon"

  tags = {
    Name = "Meu computador"
    Owner = "Amadeus Amorim"
    project = "Phoenix"
  }
}

resource "aws_instance" "my_amazon" {
  ami           = "ami ID da minha imagem Amazon (ver ID na AWS)"
  instance_type = "t3.micro"

  tags = {
    Name = "Meu servidor Amazon Linux"
    Owner = "Amadeus Amorim"
  }
} 