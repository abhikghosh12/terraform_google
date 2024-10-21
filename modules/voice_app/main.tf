# modules/voice_app/main.tf

resource "kubernetes_namespace" "voice_app" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "voice_app" {
  name      = var.release_name
  chart     = var.chart_path
  namespace = kubernetes_namespace.voice_app.metadata[0].name

  set {
    name  = "webapp.image"
    value = var.webapp_image
  }

  set {
    name  = "worker.image"
    value = var.worker_image
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.hosts[0].host"
    value = var.domain_name
  }
}

resource "google_compute_address" "voice_app" {
  name   = "voice-app-ip"
  region = var.region
}

resource "kubernetes_ingress_v1" "voice_app" {
  metadata {
    name      = "voice-app-ingress"
    namespace = kubernetes_namespace.voice_app.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                 = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = google_compute_address.voice_app.name
    }
  }

  spec {
    rule {
      host = var.domain_name
      http {
        path {
          path = "/"
          backend {
            service {
              name = "${var.release_name}-voice-app"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
