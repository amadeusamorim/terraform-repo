provider "aws" {
  region = "us-west-2"
}


resource "aws_iam_user" "user" {
  for_each = toset(var.aws_users) // toset converte uma lista em set, que atrela values nos itens e não indexes numerados.
  name     = each.value // em vez de usar os números para os índices, ele usa os valores da lista(set)
}

resource "aws_instance" "my_server" {
  for_each      = toset(["Dev", "Staging", "Prod"])
  ami           = "ami-0e472933a1395e172"
  instance_type = "t3.micro"
  tags = {
    Name  = "Server-${each.value}" // Criando cada server com um nome diferente da minha lista
    Owner = "Amadeus Amorim"
  }
}

resource "aws_instance" "server" {
  for_each      = var.servers_settings // Pega uma das variáveis das configurações de servidor, repassadas no arquivo variables
  ami           = each.value["ami"] // Cria a ami do server repassado no for_each
  instance_type = each.value["instance_type"]

  root_block_device {
    volume_size = each.value["root_disksize"]
    encrypted   = each.value["encrypted"]
  }

  volume_tags = {
    Name = "Disk-${each.key}"
  }
  tags = {
    Name  = "Server-${each.key}"
    Owner = "Amadeus Amorim"
  }
}

resource "aws_instance" "bastion_server" {
  for_each      = var.create_bastion == "YES" ? toset(["bastion"]) : [] // Se for "YES" vai criar uma set com um elemento nomeado bastion
  ami           = "ami-0e472933a1395e172"
  instance_type = "t3.micro"
  tags = {
    Name  = "Bastion Server"
    Owner = "Amadeus Amorim"
  }
}