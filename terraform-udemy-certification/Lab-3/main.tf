#----------------------------------------------------------
#
# Build WebServer during Bootstrap with External Template file
#
#----------------------------------------------------------

provider "aws" {
  region = "ca-central-1" 
}

# Ver na minha instância, botão direito, "Instance sentings" e "Edit user data" e veremos as variáveis dinâmicas
resource "aws_instance" "web" {
  ami                    = "AMI ID do Amazon Linux2"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = templatefile("user_data.sh.tpl", {
    f_name = "Amadeus"
    l_name = "Amorim"
    names = ["Ronaldo", "Zidade", "Pedro", "Neymar", "Lucas", "Cunha", "Ricks"]
  })
    tags = {
        Name    = "WebServer Built by Terraform"
        Owner   = "Amadeus Amorim"
    }
}

resource "aws_security_group" "web" {
    name        = "WebServer-SG"
    description = "(Opcional) Security Group for my WebServer"
    
    ## INBOUND RULES ##
  ingress = [{
      description      = "FW HTTP Rules"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      security_groups  = []
      prefix_list_ids = []
      self = false
    },
    {
      description      = "FW HTTPS Rules"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      security_groups  = []
      prefix_list_ids = []
      self = false
  }]

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