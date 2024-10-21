# modules/gke/main.tf

variable "create_cluster" {
  description = "Whether to create the GKE cluster"
  type        = bool
  default     = true
}

variable "disk_size_gb" {
  description = "Size of the disk attached to each node, specified in GB"
  type        = number
  default     = 25  # Changed to 25GB
}

resource "google_container_cluster" "primary" {
  count    = var.create_cluster ? 1 : 0
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {}

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