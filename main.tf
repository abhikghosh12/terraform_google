# main.tf

data "google_client_config" "default" {}

locals {
  cluster_exists = try(data.google_container_cluster.existing_cluster[0].id, "") != ""
}

data "google_container_cluster" "existing_cluster" {
  count    = local.cluster_exists ? 1 : 0
  name     = var.cluster_name
  location = var.region
  project  = var.project_id
}

module "gke" {
  source       = "./modules/gke"
  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name
  node_count   = var.node_count
  machine_type = var.machine_type

  create_cluster = !local.cluster_exists
}

module "voice_app" {
  source                   = "./modules/voice_app"
  project_id               = var.project_id
  region                   = var.region
  cluster_name             = var.cluster_name
  namespace                = var.namespace
  release_name             = var.release_name
  chart_path               = var.chart_path
  webapp_image             = var.webapp_image
  worker_image             = var.worker_image
  domain_name              = var.domain_name
  google_client_access_token = data.google_client_config.default.access_token
  cluster_endpoint         = local.cluster_exists ? data.google_container_cluster.existing_cluster[0].endpoint : module.gke.cluster_endpoint
  cluster_ca_certificate   = local.cluster_exists ? data.google_container_cluster.existing_cluster[0].master_auth[0].cluster_ca_certificate : module.gke.cluster_ca_certificate

  depends_on = [module.gke]
}