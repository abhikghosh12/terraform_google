# outputs.tf

output "cluster_name" {
  value       = module.gke.cluster_name
  description = "Name of the GKE cluster"
}

output "cluster_endpoint" {
  value       = module.gke.cluster_endpoint
  description = "Endpoint for the GKE cluster"
}

output "app_url" {
  value       = module.voice_app.app_url
  description = "URL to access the voice app"
}
