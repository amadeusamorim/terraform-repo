provider "aws" {
  region = "eu-central-1" 
  }


resource "aws_instance" "my_server_web" {
  ami = "ID da minha imagem"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags = {
    name = "Server-Web"
  }
  depends_on = [
    aws_instance.my_server_db, 
    aws_instance.my_server_app
  ]
}

# APP vai por segundo
resource "aws_instance" "my_server_app" {
  ami = "ID da minha imagem"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags = {
    name = "Server-App"
  }
  depends_on = [
    aws_instance.my_server_db
  ]
}

# DB vai ser provisionado primeiro
resource "aws_instance" "my_server_db" {
  ami = "ID da minha imagem"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.general.id]
  tags = {
    name = "Server-DB"
  }
}

resource "aws_security_group" "general" {
  name = "My Security Group"

  dynamic "ingress"{
    for_each = ["80", "443", "22"]
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My SecurityGroup"
  }
} 
}

# Terraform output ajuda a caso você não esteja com o Ambiente da Cloud acessível, ter uma noção do que está sendo feito por meio do output
output "my_securitygroup_id" {
  # value = "HelloWorld" // Mostra o nome do meu output, com o valor declarado na variável, após o Terraform Apply
  description = "Security Group ID for my Servers" // Descrição para mim, apenas
  value = aws_security_group.general.id // Mostra o ID do meu SG
}

output "my_securitygroup_all_details" {
  description = "Todo detalhe do meu Security Group para os meus servidores"
  value = aws_security_group.general // Printa tudo, como se fosse em formato json (não fica tão visualmente bonito)
}

output "web_private_ip" {
  value = aws_instance.my_server_web.private_ip // Private IP do meu Web Server
}

output "app_private_ip" {
  value = aws_instance.my_server_app.private_ip // Private IP do meu App Server
}

output "db_private_ip" {
  value = aws_instance.my_server_db.private_ip // Private IP do meu DB Server
}

output "instances_ids" {
  value = [
    aws_instance.my_server_web.id,
    aws_instance.my_server_app.id,
    aws_instance.my_server_db.id
  ]
}