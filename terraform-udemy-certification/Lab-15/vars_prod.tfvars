# Só passo o nome da variável e o valor
# Se eu apagar minhas variáveis do meu arquivo variables, essas variáveis desse arquivo vão preencher as variáveis faltantes por lá
# Para o terraform escolher esse arquivo em vez do staging tenho que passar:
# terraform apply -var-file="vars_prod.tfvars"

aws_region    = "ca-central-1"
port_list     = ["80", "443", "8443"]
instance_size = "t3.large"
key_pair      = "CanadaKey"

tags = {
  Owner       = "Amadeus Amorim"
  Environment = "Prod"
  Project     = "Phoenix"
  Code        = "334455"
}