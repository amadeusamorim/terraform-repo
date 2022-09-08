#----------------------------------------------------------
#
# Build WebServer during Bootstrap
#
#----------------------------------------------------------

provider "aws" {
  region = "ca-central-1" # Canadá Central
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_instance" "web" {
  ami                    = "AMI ID do Amazon Linux2"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  // Tudo que eu escrever entre o EOF, será o meu script
  // Teste se o meu Script ira funcionar dentro da minha VM
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with PrivateIP: $MYIP</h2><br>Built by Terraform" > /var/www/html/index.html
service httpd start
chkconfig httpd on
EOF
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
      cidr_blocks      = ["0.0.0.0/0"] // Permito toda conexão
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
      cidr_blocks      = ["0.0.0.0/0"] // Permito toda conexão
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