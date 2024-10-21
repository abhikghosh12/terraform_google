# main.tf

data "google_client_config" "default" {}

module "gke" {
  source       = "./modules/gke"
  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name
  node_count   = var.node_count
  machine_type = var.machine_type
}

module "voice_app" {
  source       = "./modules/voice_app"
  project_id   = var.project_id
  region       = var.region
  cluster_name = module.gke.cluster_name
  namespace    = var.namespace
  release_name = var.release_name
  chart_path   = var.chart_path
  webapp_image = var.webapp_image
  worker_image = var.worker_image
  domain_name  = var.domain_name

  depends_on = [module.gke]
}