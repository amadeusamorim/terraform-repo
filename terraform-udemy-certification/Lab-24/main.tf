provider "aws" {
  region = "ca-central-1"
}

provider "aws" {
  region = "us-west-2"
  alias  = "DEV" // Sempre usar um alias quando tiver um provider igual

  assume_role {
    role_arn = "arn:aws:iam::639130796919:role/TerraformRole" // ARN são identificadores únicos para os recursos AWS
  }
}

provider "aws" {
  region = "ca-central-1"
  alias  = "PROD"

  assume_role {
    role_arn = "arn:aws:iam::032823347814:role/TerraformRole"
  }
}

#============================================================================

resource "aws_vpc" "master_vpc" { // VPC é equivalente as VNets na Azure
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Master VPC"
  }
}

resource "aws_vpc" "dev_vpc" {
  provider   = aws.DEV // Provider diferente (DEV)
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Dev VPC"
  }
}

resource "aws_vpc" "prod_vpc" {
  provider   = aws.PROD // Provider diferente (PROD)
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Prod VPC"
  }
}