variable "aws_users" {
  description = "List of IAM Users to create"
  default = [ // Se eu apagar um user da lista, ele não vai precisar refazer os ambientes por estarem atrelados aos indexes numerados, mas so irão deletar os indexes com valor referente a exclusão
    "ama@astahov.net",
    "neymar@astahov.net",
    "terraform@astahov.net",
    "junior@astahov.net",
    "robby@astahov.net",
    "simone@astahov.net",
    "hoje@astahov.net",
    "josef@astahov.net"
  ]
}

variable "servers_settings" {
  type = map(any)
  default = {
    web = {
      ami           = "ami-0e472933a1395e172"
      instance_size = "t3.small"
      root_disksize = 20
      encrypted     = true
    }
    app = {
      ami           = "ami-07dd19a7900a1f049"
      instance_size = "t3.micro"
      root_disksize = 10
      encrypted     = false
    }
  }
}


variable "create_bastion" {
  description = "Provision Bastion Server YES/NO"
  default     = "NO"
}