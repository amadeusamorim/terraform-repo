#----------------------------------------------------------
#
# Build WebServer during Bootstrap with External file
#
#----------------------------------------------------------

provider "aws" {
  region = "ca-central-1" # Canadá Central
}

resource "aws_instance" "web" {
  ami                    = "AMI ID do Amazon Linux2"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  // A built-in function file traz o arquivo que consta na mesma pasta, colocada como parâmetro, para dentro do código.
  user_data              = file("user_data.sh")
    tags = {
        Name    = "WebServer Built by Terraform"
        Owner   = "Amadeus Amorim"
    }
}

resource "aws_security_group" "web" {
    name        = "WebServer-SG"
    description = "(Opcional) Security Group for my WebServer"
    
    ## INBOUND RULES ##
    ingress = {
        description = "Allow port HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Permito toda conexão
    }

    ingress = {
        description = "Allow port HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Permito toda conexão
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