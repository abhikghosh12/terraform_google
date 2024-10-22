resource "google_container_cluster" "primary" {
  count                    = var.create_cluster ? 1 : 0
  name                     = var.cluster_name
  location                 = var.zones[0]  # Using specific zone instead of region
  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {}

  # Enable CSI driver
  addons_config {
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [name]
  }
}

resource "google_container_node_pool" "primary_nodes" {
  count      = var.create_cluster ? 1 : 0
  name       = "${var.cluster_name}-node-pool"
  location   = var.zones[0]  # Using specific zone instead of region
  cluster    = google_container_cluster.primary[0].name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_type    = "pd-standard"
    disk_size_gb = var.disk_size_gb

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

data "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zones[0]  # Using specific zone instead of region
  project  = var.project_id

  depends_on = [google_container_cluster.primary]
}
