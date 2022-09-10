# Para o terraform escolher esse arquivo em vez do staging tenho que passar:
# terraform apply -var-file="vars_staging.tfvars"

aws_region    = "ca-central-1"
port_list     = ["80", "443", "8443"]
instance_size = "t2.micro"
key_pair      = "CanadaKey"

tags = {
  Owner       = "Amadeus Amorim"
  Environment = "Staging"
  Project     = "Phoenix"
  Code        = "445555"
}