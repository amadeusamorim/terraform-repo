provider "aws" {
  region = "eu-central-1" 
  }

# Depends on, como o nome já infere, uma instância dependerá de outra, tanto para iniciar, como para ser destruída.

# Web por terceiro
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