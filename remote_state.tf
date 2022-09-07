# Using a single workspace:
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    # Nome da organização criado no site do Hashicorp
    organization = "amadeuslabs"
    # Nome da infra que estou gerenciando
    workspaces {
      name = "aws-amadeuslabs"
    }
  }
}
# Iniciar novamente o Terraform