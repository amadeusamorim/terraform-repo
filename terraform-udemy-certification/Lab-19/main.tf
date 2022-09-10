

provider "aws" {
  region = "us-west-2"
}

data "aws_region" "current" {}

resource "aws_default_vpc" "default" {} 

resource "aws_instance" "my_server" {
  ami                    = var.ami_id_per_region[data.aws_region.current.name] // Pega a região pelo nome da região do arquivo e no arquivo var, vai achar a ami apropriada
  instance_type          = lookup(var.server_size, var.env, var.server_size["my_default"]) // Primeiro argumento é o map {}, segundo é a key (valor dentro do map) e terceiro é caso não tenha a key, é o default.
  vpc_security_group_ids = [aws_security_group.my_server.id]

  root_block_device {
    volume_size = 10
    encrypted   = (var.env == "prod") ? true : false // Condicional, se for para produção é true e se não for é false
  } // Se a condicional for verdadeira, você coloca o argumento depois da interrogação, se for falso, depois de :

# Bloco dinâmico
  dynamic "ebs_block_device" {
    for_each = var.env == "prod" ? [true] : [] // Se for de produção, fazer uma lista vazia
    content {
      device_name = "/dev/sdb"
      volume_size = 40 // Tamanho em giga do meu disco
      encrypted   = true
    }
  }

  volume_tags = { Name = "Disk-${var.env}" }
  tags        = { Name = "Server-${var.env}" }
}


resource "aws_security_group" "my_server" {
  name   = "My Server Security Group"
  vpc_id = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  dynamic "ingress" {
    for_each = lookup(var.allow_port, var.env, var.allow_port["rest"]) // Primeiro argumento é o map {}, segundo é a key (valor dentro do map) e terceiro é caso não tenha a key, é o default.
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "My Server Dynamic SG"
    Owner = "Amadeus Amorim"
  }
}