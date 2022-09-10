
provider "aws" {
  region = "ca-central-1"
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_instance" "myserver" { // Cria um VM
  ami                    = "ami-0c9bfc21ac5bf10eb"
  instance_type          = "t3.nano"
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = "amadeus-key-ca-central-1"
  tags = {
    Name  = "My EC2 with remote-exec"
    Owner = "Amadeus Amorim"
  }

# Lembrando que sempre usar o provisioner em última instância

  provisioner "remote-exec" { // Executa esses comandos dentro da VM
    inline = [
      "mkdir /home/ec2-user/terraform",
      "cd /home/ec2-user/terraform",
      "touch hello.txt",
      "echo 'Terraform was here...' > terraform.txt"
    ] // Executar uma lista de comandos
    connection { // Loga na VM
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip // Mesma coisa que: aws_instance.myserver.public_ip
      private_key = file("amadeus-key-ca-central-1.pem")
    }
  }
}


resource "aws_security_group" "web" {
  name   = "My-SecurityGroup"
  vpc_id = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "SG by Terraform"
    Owner = "Amadeus Amorim"
  }
}