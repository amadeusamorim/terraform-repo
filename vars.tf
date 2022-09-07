
# Crio variáveis para minhas imagens das VMs e pelo main tenho acesso
variable "amis" {
    type = "map"
    default = {
        "us-east-1" = "ami-026c8acd927181916b"
        "us-east-2" = "ami-0d8f6eb4f641ef691"
    }
}

variable "cidr_acesso_remoto" {
    type = "list"
    default = ["177.83.197.84/32", "178.83.197.84/32"]
}

# Se não passarmos o type, ele vai entender que estamos passando uma string
variable "key_name" {
    default = "terraform-aws"

}