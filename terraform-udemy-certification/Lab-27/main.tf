
provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "node1" {
  ami           = "ami-05655c267c89566dd"
  instance_type = "t3.micro"
  tags = {
    Name  = "Node-1"
    Owner = "Amadeus Amorim"
  }
}

resource "aws_instance" "node2" { // Se eu comentar e der apply e depois descomentar e usar o taint com o aws_instance.node2, o recurso se recupera
  ami           = "ami-05655c267c89566dd"
  instance_type = "t3.micro"
  tags = {
    Name  = "Node-2"
    Owner = "Amadeus Amorim"
  }
}

resource "aws_instance" "node3" {
  ami           = "ami-05655c267c89566dd"
  instance_type = "t3.micro"
  tags = {
    Name  = "Node-3"
    Owner = "Amadeus Amorim"
  }
  depends_on = [aws_instance.node2]
}