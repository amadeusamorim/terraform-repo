provider "aws" {
  region = "ca-central-1"
}

/*
resource "aws_instance" "myserver" {
  ami = data.aws.ami.latest_ubuntu20.id
  instance_type = "t3.micro"
}
*/

# AINDA QUE VOCÊ MUDE DE REGIÃO O CÓDIGO VAI PROCURAR POR VOCÊ A IMAGEM COM A ÚLTIMA VERSÃO

# Encontra a ultima versão da imagem do ubuntu20 diretamente da AWS
data "aws_ami" "latest_ubuntu20" {
  owners = ["099720109477"] // Real dono da imagem
  most_recent = true // Pega a última versão de todas as escolhidas (*)
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] // O * representa as versões
  }
}

# Encontra a ultima versão da imagem do ubuntu20 diretamente da Amazon Linux
data "aws_ami" "latest_amazonlinux" {
  owners = ["137112412989"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_windowsserver2019" {
  owners = ["801119661308"]
  most_recent = true
  filter {
    name = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

output "latest_ubunto20_ami_id" {
  value = data.aws_ami.latest_ubuntu20.id
}

output "latest_amazonlinux" {
  value = data.aws_ami.latest_amazonlinux.id
}

output "latest_windowsserver2019" {
 value =  data.aws_ami.latest_windowsserver2019.id
}