output "user_arns" {
  value = values(aws_iam_user.user)[*].arn // Vai imprimir todos os valores de todos os usuários do json referente ao nome dos recursos (arn)
}

output "prod_instance_id" {
  value = aws_instance.my_server["Prod"].id // Vou imprimir o id do meu servidor Prod
}

output "instances_ids" {
  value = values(aws_instance.my_server)[*].id // Imprimo todas as ids das minhas instâncias
}

output "instances_public_ips" {
  value = values(aws_instance.my_server)[*].public_ip // Imprimo todos os IPs públicos das minhas instancias
}

output "bastion_public_ip" {
  value = var.create_bastion == "YES" ? aws_instance.bastion_server["bastion"].public_ip : null
}