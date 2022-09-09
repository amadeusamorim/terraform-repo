provider "aws" {
  region = "us-west-2" 
  }

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

# ELASTIC IP
resource "aws_eip" "web" {
  vpc      = true
  instance = aws_instance.web.id // Referencio minha instancia
  tags = {
    Name  = "EIP for WebServer Built by Terraform"
    Owner = "Amadeus Amorim"
  }
}

resource "aws_instance" "web" {
  ami                    = "AMI ID do Amazon Linux2"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = file("user_data.sh")
    tags = {
        Name    = "WebServer Built by Terraform"
        Owner   = "Amadeus Amorim"
    }
}

# Antes de destruir uma instância antiga, ele cria uma nova e fica praticamente sem downtime
lifecycle {
  create_before_destroy = true
}

resource "aws_security_group" "web" {
    name        = "WebServer-SG"
    description = "(Opcional) Security Group for my WebServer"
    
    ## INBOUND RULES ##

  # Ingress dinâmicos, com os valores que constam na lista (foreach)
  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description      = "FW HTTP Rules"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

    ## OUTBOUND RULES ##
    egress = {
        description = "Allow ALL ports"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name    = "WebServer SG by Terraform"
        Owner   = "Amadeus Amorim"

    }
  
}