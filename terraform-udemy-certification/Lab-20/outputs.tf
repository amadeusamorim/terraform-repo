output "instance_ids" {
  value = aws_instance.servers[*].id // Como cria indexes ao criar as indexes, passo o * para que todos os outputs sejam impressos
}

output "instance_public_ips" {
  value = aws_instance.servers[*].public_ip 
}

output "iam_users_arn" {
  value = aws_iam_user.user[*].arn // Imprime os IAM Users
}

output "bastion_public_ip" {
  value = var.create_bastion == "YES" ? aws_instance.bastion_server[0].public_ip : null // Se tiver a VM do Bastion, printa, se não, é null
}