
### SECURITY GROUP ###

# Arquivos no mesmo diretório se comunicam

# Cria o acesso ao Security Group e Dá o nome de acesso-ssh
resource "aws_security_group" "acesso-ssh" { 
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
    # Descrição é opcional
    description      = "Porta que o SSH funciona"
    # Porta que quero ter acesso (TCP do SSH)
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    # CDIR são as boas práticas de segurança e determina os IPs permitidos
    # No meu caso, coloquei o meu IP dinâmico, mas nas empresas, habitualmente são fixos
    # Abrir em 0.0.0.0/0 pode gerar problemas de vulnerabilidade em sua segurança.
    # Acessando meu cdir_block por meio de variável
    cidr_blocks      = "${var.cidr_acesso_remoto}"
# Se meu IP for IPV6, colocar no campo abaixo
#    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  tags = {
    name = "ssh"
  }
}
# Após essas configurações modificando meu ambiente, já posso conectar na minha VM via SSH.

resource "aws_security_group" "acesso-ssh-us-east-2" {
  # A diferença do meu Security Group para o outro é a ligação ao meu novo provider de outra região (utilizando alias).
  provider = "aws.us-east-2"
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
    description      = "Porta que o SSH funciona"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = "${var.cidr_acesso_remoto}"
  }
  tags = {
    name = "ssh"
  }
}