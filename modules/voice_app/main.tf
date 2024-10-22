# modules/voice_app/main.tf

resource "kubernetes_namespace" "voice_app" {
  metadata {
    name = var.namespace
  }
}

resource "google_compute_address" "voice_app" {
  name   = "voice-app-ip"
  region = var.region
}

resource "helm_release" "voice_app" {
  name       = var.release_name
  chart      = var.chart_path
  namespace  = kubernetes_namespace.voice_app.metadata[0].name
  version    = var.chart_version
  timeout    = 900

  wait       = true
  wait_for_jobs = true

  values = [
    templatefile("${path.module}/templates/voice_app_values.yaml.tpl", {
      webapp_image_tag     = var.webapp_image_tag
      worker_image_tag     = var.worker_image_tag
      webapp_replica_count = var.webapp_replica_count
      worker_replica_count = var.worker_replica_count
      ingress_enabled      = var.ingress_enabled
      ingress_host         = var.ingress_host
      uploads_storage_size = var.uploads_storage_size
      output_storage_size  = var.output_storage_size
      redis_storage_size   = var.redis_master_storage_size
    })
  ]

  depends_on = [
    kubernetes_namespace.voice_app
  ]
}
