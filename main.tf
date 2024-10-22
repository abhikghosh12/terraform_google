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
  chart_path                = var.chart_path
  chart_version             = var.chart_version
  
  # Image configurations
  webapp_image              = var.webapp_image
  worker_image              = var.worker_image
  webapp_image_tag          = split(":", var.webapp_image)[1]
  worker_image_tag          = split(":", var.worker_image)[1]
  
  # Replica counts
  webapp_replica_count      = var.webapp_replica_count
  worker_replica_count      = var.worker_replica_count
  
  # Storage configurations
  uploads_storage_size        = var.uploads_storage_size
  output_storage_size         = var.output_storage_size
  redis_master_storage_size   = var.redis_master_storage_size
  redis_replicas_storage_size = var.redis_replicas_storage_size
  
  # Ingress configurations
  domain_name               = var.domain_name
  ingress_host             = var.domain_name  # Using domain_name as ingress_host
  ingress_enabled          = var.ingress_enabled
  create_ingress           = var.create_ingress
  
  # Authentication and cluster access
  google_client_access_token = data.google_client_config.default.access_token
  cluster_endpoint          = module.gke.cluster_endpoint
  cluster_ca_certificate    = module.gke.cluster_ca_certificate

  depends_on = [module.gke]
}