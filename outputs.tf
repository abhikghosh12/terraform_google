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
  value       = "https://${var.domain_name}"
  description = "URL to access the voice app"
}

output "ingress_ip" {
  value       = module.voice_app.ingress_ip
  description = "IP address of the ingress"
}
