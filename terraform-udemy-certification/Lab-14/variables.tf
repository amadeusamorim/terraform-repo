# Tudo que faz a gente mudar os parâmetros nós podemos colocar em variables

variable "aws_region" {
  description = "Region where you want to provision this EC2 WebServer"
  type        = string // pode ser number ou bool (true or false)
  default     = "ca-central-1"
}

variable "port_list" {
  description = "List of Poret to open for our WebServer"
  type        = list(any) // Any significa que pode ser string, number, etc
  default     = ["80", "443"]
}

variable "instance_size" {
  description = "EC2 Instance Size to provision" // Reforçando que Descrição não é obrigatório
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Tags to Apply to Resources"
  type        = map(any) // Lembrando que map é entre brackets {}
  default = {
    Owner       = "Amadeus Amorim"
    Environment = "Prod"
    Project     = "Phoenix"
  }
}

variable "key_pair" {
  description = "SSH Key pair name to ingest into EC2"
  type        = string
  default     = "CanadaKey"
  sensitive   = true // Sensitivo não mostra no output
}

variable "password" {
  description = "Please Enter Password lenght of 10 characters!"
  type        = string
  sensitive   = true
  validation { // Validação tem dois parâmetros, condição e msg de erro
    condition     = length(var.password) == 10 // Coloca uma condição do tamanho ser exatamente com 10 de tamanho
    error_message = "Your Password must be 10 characted exactly!!!"
  }
}