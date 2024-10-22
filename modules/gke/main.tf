# modules/gke/main.tf
resource "google_container_cluster" "primary" {
  count                    = var.create_cluster ? 1 : 0
  name                     = var.cluster_name
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  networking_mode          = "VPC_NATIVE"
  ip_allocation_policy     {}
  min_master_version       = var.kubernetes_version

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [name]
  }
}

resource "google_container_node_pool" "primary_nodes" {
  count      = var.create_cluster ? 1 : 0
  name       = "${var.cluster_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary[0].name
  node_count = var.node_count
  version    = var.kubernetes_version

  node_config {
    machine_type = var.machine_type
    disk_type    = "pd-ssd"
    disk_size_gb = var.disk_size_gb

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]
  }
}

data "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id

  depends_on = [google_container_cluster.primary]
}

