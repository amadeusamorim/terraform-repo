provider "aws" {
  region = "ca-central-1"
}

# Instância de produção
resource "aws_db_instance" "prod" {
  identifier           = "prod-mysql-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
  username             = "administrator"
  password             = data.aws_ssm_parameter.rds_password.value // usar o password gerado por nosso recurso abaixo
}

# Gera senhas
resource "random_password" "main" {
  length = 20 // Tamanho da senha
  special = true // Usar caracteres especiais
  override_special = "#!()_" // Listo os caracteres especiais que quero usar
}

# Guarda a senha na ssm parameter
resource "aws_ssm_parameter" "rds_password" {
  name = "/prod/prod-mysql-rds/password" // Local que guardamos a senha
  description = "Senha master para Banco de Dados RDS"
  type = "SecureString" // String encriptada
  value = random_password.main.result
}

# Retorna a senha (Usa o mesmo nome do ssm)
data "aws_ssm_parameter" "rds_password" {
  name = "/prod/prod-mysql-rds/password"
  depends_on = [
    aws_ssm_parameter.rds_password // Só pode ser criado depois que o recurso ssm for criado
  ]
}


#-------------


output "rds_address" {
  value = aws_db_instance.prod.address
}

output "rds_port" {
  value = aws_db_instance.prod.port
}

output "rds_username" {
  value = aws_db_instance.prod.username
}

output "rds_password" {
  value = data.aws_ssm_parameter.rds_password.value // Nunca é recomendado printar a sua senha, apenas para fins didáticos
  sensitive = true // Passa uma tag dizendo <sensitive> no print
}  

# O Terraform vai criar stage files derivados dos recursos acima
# Assegure em esconder bem esses arquivos porque ele mostrará as senhas criadas
