

provider "aws" {
  region = "ca-central-1"
}

# Tente nunca usar o provisioner, sempre como último recurso

resource "null_resource" "command1" {
  provisioner "local-exec" { // Comando que passa execuções locais
    command = "echo Terraform START: $(date) >> log.txt" // É basicamente um comando shell que vai pegar a data
  } // Cria um arquivo de texto na pasta desse main.tf
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com" // Pinga 5 vezes no site do google
  }
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    interpreter = ["python", "-c"] // Define o interpretador, -c é o comando para executar o comando local
    command     = "print('Hello World from Python!')" // Comando Python
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 $NAME3 >> log.txt"
    environment = { // Define as variáveis repassadas no comando
      NAME1 = "John"
      NAME2 = "Mark"
      NAME3 = "Donald"
    }
  }
}


resource "aws_instance" "myserver" {
  ami           = "ami-0c9bfc21ac5bf10eb"
  instance_type = "t3.nano"

  provisioner "local-exec" { // Reforçando que esse comando vai ser executado localmente e não no servidor
    command = "echo ${aws_instance.myserver.private_ip} >> log.txt"
  }
}

resource "null_resource" "command5" {
  provisioner "local-exec" {
    command = "echo Terraform FINISH: $(date) >> log.txt"
  }
  depends_on = [
    null_resource.command1,
    null_resource.command2,
    null_resource.command3,
    null_resource.command4,
    aws_instance.myserver
  ] // Comando que vai depender de todos os outros local-exec
}