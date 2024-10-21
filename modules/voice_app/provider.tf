# modules/voice_app/provider.tf

provider "kubernetes" {
  host                   = "https://${var.cluster_endpoint}"
  token                  = var.google_client_access_token 
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${var.cluster_endpoint}"
    token                  = var.google_client_access_token 
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}




