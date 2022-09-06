# Parâmetro obrigatório, informar o provider, a versão e a região
provider "aws" {
	version = "~> 2.0"
	region = "us-east-1"
}

# Criando uma nova região
provider "aws" {
  # Criando um alias para que não dê problema com os nomes iguais dos providers
  alias = "us-east-2"
	version = "~> 2.0"
	region = "us-east-2"
}

### INSTÂNCIAS ###

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
      name = "dev${count.index}" 
	}
    # Vinculando meu Security Group na minha instância usando o ID do grupo da AWS
    # Substitui os security groups criados anteriormente 
    # Utilizo a referência do meu acesso-ssh para ler o meu ID do RG de forma dinâmica
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

# Nova instância para o meu bucket
# A máquina 4 vai ser criada após a criação do bucket, pois depende dela
resource "aws_instance" "dev4" { 
	ami = "ami-026c8acd927181916b" 
	instance_type = "t2.micro" 
	key_name = "terraform-aws" 
	tags = {
      name = "dev4" 
	}
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
    depends_on = [
      aws_s3_bucket.dev4
    ]
}

resource "aws_instance" "dev5" { 
	ami = "ami-026c8acd927181916b" 
	instance_type = "t2.micro" 
	key_name = "terraform-aws" 
	tags = {
      name = "dev5" 
	}
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

# Outra região
resource "aws_instance" "dev6" {
  provider = "aws.us-east-2"
  # Faço referência a minha nova VM
	ami = "ami-0d8f6eb4f641ef691" 
	instance_type = "t2.micro" 
	key_name = "terraform-aws" 
	tags = {
      name = "dev6" 
	}
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
    depends_on = [
      "aws_dynamodb_table.dynamodb-homologacao"
    ]
}

### BUCKET ###

# Vinculo esse recurso a uma nova máquina de desenvolvimento
# Na AWS o bucket é multiregional e não precisa vincular uma região
resource "aws_s3_bucket" "dev4" {
  # Nome do meu bucket
  bucket = "amadeusamorim-labs-dev4"
  # Permissionamento do meu bucket (privado)
  acl    = "private"

  tags = {
    Name        = "amadeusamorim-labs-dev4"
  }
}

### DATABASE ###

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider = "aws.us-east-2"
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}