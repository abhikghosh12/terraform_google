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
  timeout    = 900

  dependency_update = true

  # Image configurations
  set {
    name  = "webapp.image.repository"
    value = split(":", var.webapp_image)[0]
  }

  set {
    name  = "webapp.image.tag"
    value = split(":", var.webapp_image)[1]
  }

  set {
    name  = "worker.image.repository"
    value = split(":", var.worker_image)[0]
  }

  set {
    name  = "worker.image.tag"
    value = split(":", var.worker_image)[1]
  }

  # Storage configurations
  set {
    name  = "persistence.uploads.enabled"
    value = "true"
  }

  set {
    name  = "persistence.uploads.storageClass"
    value = "standard"  # Changed from standard-rwo
  }

  set {
    name  = "persistence.uploads.size"
    value = "5Gi"
  }

  set {
    name  = "persistence.output.enabled"
    value = "true"
  }

  set {
    name  = "persistence.output.storageClass"
    value = "standard"  # Changed from standard-rwo
  }

  set {
    name  = "persistence.output.size"
    value = "5Gi"
  }

  # Redis configurations
  set {
    name  = "redis.master.persistence.storageClass"
    value = "standard"
  }

  set {
    name  = "redis.replica.persistence.storageClass"
    value = "standard"
  }

  # Ingress configurations
  set {
    name  = "ingress.enabled"
    value = var.ingress_enabled
  }

  set {
    name  = "ingress.host"
    value = var.ingress_host
  }

  depends_on = [
    kubernetes_namespace.voice_app
  ]
}
