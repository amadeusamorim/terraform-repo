variable "env" {
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" { // Que subnets públicas preciso criar
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
}

variable "private_subnet_cidrs" { // Subnets privadas preciso criar
  default = [
    "10.0.11.0/24",
    "10.0.22.0/24",
  ]
}

variable "tags" {
  default = {
    Owner   = "Amadeus Amorim"
    Project = "Phoenix"
  }
}