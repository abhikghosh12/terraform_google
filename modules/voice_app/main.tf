# modules/voice_app/main.tf

resource "kubernetes_namespace" "voice_app" {
  metadata {
    name = var.namespace
  }
}

# Create PVCs using default storage class
resource "kubernetes_persistent_volume_claim" "app_data" {
  metadata {
    name      = "voice-app-data"
    namespace = kubernetes_namespace.voice_app.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "redis_data" {
  metadata {
    name      = "redis-data"
    namespace = kubernetes_namespace.voice_app.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

# Remove any existing ingress before Helm release
resource "null_resource" "remove_existing_ingress" {
  provisioner "local-exec" {
    command = "kubectl delete ingress -n ${var.namespace} voice-app-ingress --ignore-not-found=true"
  }
}

resource "helm_release" "voice_app" {
  name       = var.release_name
  chart      = var.chart_path
  namespace  = kubernetes_namespace.voice_app.metadata[0].name
  force_update  = true
  replace    = true

  set {
    name  = "worker.image.repository"
    value = split(":", var.worker_image)[0]
  }

  set {
    name  = "worker.image.tag"
    value = split(":", var.worker_image)[1]
  }

  set {
    name  = "webapp.image.repository"
    value = split(":", var.webapp_image)[0]
  }

  set {
    name  = "webapp.image.tag"
    value = split(":", var.webapp_image)[1]
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.app_data.metadata[0].name
  }

  set {
    name  = "redis.master.persistence.enabled"
    value = "true"
  }

  set {
    name  = "redis.master.persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.redis_data.metadata[0].name
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "gce"
  }

  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.global-static-ip-name"
    value = google_compute_address.voice_app.name
  }

  set {
    name  = "ingress.hosts[0].host"
    value = var.domain_name
  }

  depends_on = [
    kubernetes_persistent_volume_claim.app_data,
    kubernetes_persistent_volume_claim.redis_data,
    null_resource.remove_existing_ingress
  ]
}

resource "google_compute_address" "voice_app" {
  name   = "voice-app-ip"
  region = var.region

  lifecycle {
    ignore_changes = [name]
    prevent_destroy = true
  }
}
