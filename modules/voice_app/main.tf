# modules/voice_app/main.tf

resource "kubernetes_namespace" "voice_app" {
  metadata {
    name = var.namespace
  }
}

# PVC for uploads
resource "kubernetes_persistent_volume_claim" "voice_app_uploads" {
  metadata {
    name      = "voice-app-uploads"
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteOnce"]  # Using RWO as we're using standard-rwo
    resources {
      requests = {
        storage = var.uploads_storage_size
      }
    }
    # Using default storage class (standard-rwo)
  }
}

# PVC for output
resource "kubernetes_persistent_volume_claim" "voice_app_output" {
  metadata {
    name      = "voice-app-output"
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = var.output_storage_size
      }
    }
    # Using default storage class (standard-rwo)
  }
}

# PVC for Redis master
resource "kubernetes_persistent_volume_claim" "redis_master" {
  metadata {
    name      = "redis-master"
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    storage_class_name = "standard" # Using standard for Redis (immediate binding)
    resources {
      requests = {
        storage = var.redis_master_storage_size
      }
    }
  }
}

# PVC for Redis replicas
resource "kubernetes_persistent_volume_claim" "redis_replicas" {
  metadata {
    name      = "redis-replicas"
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    storage_class_name = "standard" # Using standard for Redis (immediate binding)
    resources {
      requests = {
        storage = var.redis_replicas_storage_size
      }
    }
  }
}

resource "helm_release" "voice_app" {
  name      = var.release_name
  chart     = var.chart_path
  namespace = var.namespace
  version   = var.chart_version

  values = [
    templatefile("${path.module}/templates/voice_app_values.yaml.tpl", {
      webapp_image_tag     = var.webapp_image_tag
      worker_image_tag     = var.worker_image_tag
      webapp_replica_count = var.webapp_replica_count
      worker_replica_count = var.worker_replica_count
      ingress_enabled      = var.ingress_enabled
      ingress_host         = var.ingress_host
    })
  ]

  # Persistence configuration
  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.uploads.existingClaim"
    value = kubernetes_persistent_volume_claim.voice_app_uploads.metadata[0].name
  }

  set {
    name  = "persistence.output.existingClaim"
    value = kubernetes_persistent_volume_claim.voice_app_output.metadata[0].name
  }

  # Redis configuration
  set {
    name  = "redis.master.persistence.enabled"
    value = "true"
  }

  set {
    name  = "redis.master.persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.redis_master.metadata[0].name
  }

  set {
    name  = "redis.replica.persistence.enabled"
    value = "true"
  }

  set {
    name  = "redis.replica.persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.redis_replicas.metadata[0].name
  }

  # Ingress configuration
  set {
    name  = "ingress.enabled"
    value = var.ingress_enabled
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
    name  = "ingress.host"
    value = var.ingress_host
  }

  depends_on = [
    kubernetes_persistent_volume_claim.voice_app_uploads,
    kubernetes_persistent_volume_claim.voice_app_output,
    kubernetes_persistent_volume_claim.redis_master,
    kubernetes_persistent_volume_claim.redis_replicas,
  ]
}

resource "google_compute_address" "voice_app" {
  name   = "voice-app-ip"
  region = var.region
}