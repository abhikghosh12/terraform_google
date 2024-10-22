# provider.tf

terraform {
  required_version = ">= 0.14"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
  backend "gcs" {
    bucket = "terraform_state_files_voice"
    prefix = "terraform/state"
  }
}

# Google provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Get Google credentials
data "google_client_config" "default" {}

# Get GKE cluster info
data "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = "europe-west1-b"  # Specific zone where the cluster exists
  project  = var.project_id
}

# Kubernetes provider
provider "kubernetes" {
  host  = "https://${data.google_container_cluster.primary.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

# Helm provider
provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.primary.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  }
}



