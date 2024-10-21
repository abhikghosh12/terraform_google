# modules/voice_app/outputs.tf

output "app_url" {
  value       = "http://${google_compute_address.voice_app.address}"
  description = "URL to access the voice app"
}
