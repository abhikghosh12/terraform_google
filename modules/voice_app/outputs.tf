# modules/voice_app/outputs.tf

output "app_url" {
  value       = "http://${google_compute_address.voice_app.address}"
  description = "URL to access the voice app"
}

output "ingress_ip" {
  value       = google_compute_address.voice_app.address
  description = "IP address of the ingress"
}

output "namespace" {
  value       = kubernetes_namespace.voice_app.metadata[0].name
  description = "Namespace where the application is deployed"
}
