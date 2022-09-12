provider "aws" {
  region = "us-west-2"
}


resource "aws_instance" "servers" {
  count         = 4 // Quantos servers queremos?
  ami           = "ami-0e472933a1395e172"
  instance_type = "t3.micro"
  tags = {
    Name  = "Server Number ${count.index + 1}" // Variável que vai mudar de acordo com a quantidade de servers que criaremos. (count começa com 0)
    Owner = "Amadeus Amorim"
  }
}

resource "aws_instance" "servers" {
  count         = 4 // Quantos servers queremos?
  ami           = "ami-0e472933a1395e172"
  instance_type = "t3.micro"
  tags = {
    Name  = "Server Number ${count.index + 1}" // Variável que vai mudar de acordo com a quantidade de servers que criaremos. (count começa com 0)
    Owner = "Amadeus Amorim"
  }
}

resource "aws_iam_user" "user" {
  count = length(var.aws_users) // Vai pegar a quantidade de itens que tem na lista // Count não é apropriado para criar IAM Users
  name  = element(var.aws_users, count.index) // element pega o elemento da lista, passando a lista como parâmetro e o count, ou seja o index (dois parâmetros)
}

resource "aws_instance" "bastion_server" {
  count         = var.create_bastion == "YES" ? 1 : 0 // Condicional é mais propício do que usar o length, por exemplo. Só cria se a variável for true
  ami           = "ami-0e472933a1395e172"
  instance_type = "t3.micro"
  tags = {
    Name  = "Bastion Server"
    Owner = "Amadeus Amorim"
  }
}