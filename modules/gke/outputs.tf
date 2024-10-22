# modules/gke/outputs.tf

output "cluster_name" {
  value = var.create_cluster ? google_container_cluster.primary[0].name : var.cluster_name
  description = "Name of the GKE cluster"
}

output "cluster_endpoint" {
  value = var.create_cluster ? google_container_cluster.primary[0].endpoint : data.google_container_cluster.primary.endpoint
  description = "Endpoint for the GKE cluster"
}

output "cluster_ca_certificate" {
  value = var.create_cluster ? google_container_cluster.primary[0].master_auth[0].cluster_ca_certificate : data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  description = "CA certificate for the GKE cluster"
  sensitive = true
}
