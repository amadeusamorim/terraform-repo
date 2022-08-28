# Parâmetro obrigatório, informar o provider, a versão e a região
provider "aws" {
	version = "~> 2.0"
	region = "us-east-1"
}

# Se é um recurso, tenho que colocar uma instância
# Abaixo coloco o tipo da instância e nome dela
resource "aws_instance" "dev" { 
# Faço o deploy de 3 máquinas
	count = 3 
# Imagem relacionada ao meu Ubuntu server
	ami = "ami-026c8acd927181916b" 
# Máquina free tier dentro da licença AWS
	instance_type = "t2.micro" 
# Nome escolhido no ato da criação da chave via terminal
	key_name = "terraform-aws" 
# Nome da tag, fazendo referência ao index do computador para ficar diferente uma da outra
	tags = {
			Name = "dev${count.index}" 
	}
# Vinculando meu Security Group na minha instância usando o ID do grupo da AWS
# Substitui os security groups criados anteriormente    
    vpc_security_group_ids = ["sg-0494f947ad5a9858c"]
}

# Cria o acesso ao Security Group e Dá o nome de acesso-ssh
resource "aws_security_group" "acesso-ssh" { 
  name        = "acesso-ssh"
  description = "acesso-ssh"
  vpc_id      = aws_vpc.main.id

  ingress {
# Descrição é opcional
    description      = "Porta que o SSH funciona"
# Porta que quero ter acesso (TCP do SSH)
    from_port        = 22
    to_port          = 443
    protocol         = "tcp"
# CDIR são as boas práticas de segurança e determina os IPs permitidos
# No meu caso, coloquei o meu IP dinâmico, mas nas empresas, habitualmente são fixos
# Abrir em 0.0.0.0/0 pode gerar problemas de vulnerabilidade em sua segurança.
    cidr_blocks      = ["177.83.197.84/32"]
# Se meu IP for IPV6, colocar no campo abaixo
#    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  tags = {
    Name = "ssh"
  }
}
# Após essas configurações modificando meu ambiente, já posso conectar na minha VM via SSH.