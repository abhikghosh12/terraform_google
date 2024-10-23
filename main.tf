# main.tf

data "google_client_config" "default" {}

module "gke" {
  source       = "./modules/gke"
  project_id   = var.project_id
  region       = var.region
  zones        = var.zones
  cluster_name = var.cluster_name
  node_count   = var.node_count
  machine_type = var.machine_type
  disk_size_gb = var.disk_size_gb
}

module "voice_app" {
  source                    = "./modules/voice_app"
  project_id                = var.project_id
  region                    = var.region
  cluster_name              = var.cluster_name
  namespace                 = var.namespace
  release_name              = var.release_name
  chart_path                = "${path.root}/Charts/voice-app"
  webapp_image              = var.webapp_image
  worker_image              = var.worker_image
  domain_name               = var.domain_name
  ingress_host             = var.ingress_host
  ingress_enabled          = var.ingress_enabled
  google_client_access_token = data.google_client_config.default.access_token
  cluster_endpoint          = module.gke.cluster_endpoint
  cluster_ca_certificate    = module.gke.cluster_ca_certificate

  depends_on = [module.gke]
}