provider "aws" {
  region = "ca-central-1" # Canadá Central
}

resource "aws_security_group" "web" {
    name        = "WebServer-SG"
    description = "(Opcional) Security Group for my WebServer"
    
    ## INBOUND RULES ##

  # Ingress dinâmicos, com os valores que constam na lista (foreach)
  dynamic "ingress" {
    for_each = ["80", "8080", "443", "1000", "8443"]
    content {
      description      = "FW HTTP Rules"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = ["8000", "9000", "7000", "1000"]
    content {
      description      = "Allow port UDP"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  ingress = {
      description      = "Allow port SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/0"]
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