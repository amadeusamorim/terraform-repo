
variable "aws_users" {
  description = "List of IAM Users to create"
  default = [ // Para deletar um 'email desses' apenas apago
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

variable "create_bastion" {
  description = "Provision Bastion Server YES/NO"
  default     = "NO"
}