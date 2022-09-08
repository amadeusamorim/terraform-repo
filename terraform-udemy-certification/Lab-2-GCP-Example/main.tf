# Importante exportar as variáveis para o ambiente, como passado nos comentários
provider "google" {
  credentials = file("mygcp-creds.json") // export GCLOUD_KEYFILE_JSON="gcp-creds.json"
  project     = "prod-251618"            // export GCLOUD_PROJECT="prod-251618"
  region      = "us-west1"               // export GCLOUD_REGION="us-west1"
  zone        = "us-west1-a"             // export GCLOUD_ZONE="us-west1-a"
}

resource "google_compute_instance" "my_server" {
    name = "my-gcp-server"
    machine_type = "f1-micro"
    boot_disk {
      initialize_params{
          image = "debian-cloud/debian-9"
      }
    }
    network_interface {
      network = "default" // This enable Private IP Address
      access_config {} // This enable public IP Adress
    }
}
# Você precisa criar um Service Account, dar uma permissão (Owner, na maioria das vezes) e criar uma Key em JSon format.