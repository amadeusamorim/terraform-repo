output "my_vpc_id" {
  value = module.my_vpc_default.vpc_id // Estão dentro da pasta modules e o módulo repassado no main aponta para o path
}

output "my_vpc_cidr" {
  value = module.my_vpc_default.vpc_cidr
}

output "my_public_subnet_ids" {
  value = module.my_vpc_default.public_subnet_ids
}

output "my_private_subnet_ids" {
  value = module.my_vpc_default.private_subnet_ids
}