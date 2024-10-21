# main.tf
data "google_container_cluster" "my_cluster" {
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
}

module "voice_app" {
  source                     = "./modules/voice_app"
  project_id                 = var.project_id
  region                     = var.region
  cluster_name               = var.cluster_name
  namespace                  = var.namespace
  release_name               = var.release_name
  chart_path                 = var.chart_path
  webapp_image               = var.webapp_image
  worker_image               = var.worker_image
  domain_name                = var.domain_name
  google_client_access_token = data.google_client_config.default.access_token
  cluster_endpoint           = data.google_container_cluster.my_cluster.endpoint
  cluster_ca_certificate     = data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate

  depends_on = [module.gke]
}