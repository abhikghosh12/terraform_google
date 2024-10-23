# modules/gcp-https/variables.tf
variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "domain_name" {
  description = "Domain name (e.g., voicesapp.net)"
  type        = string
  default     = "voicesapp.net"
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "voiceapp"
}

variable "static_ip" {
  description = "Static IP address for ingress"
  type        = string
  default     = "34.160.180.252"
}

variable "service_name" {
  description = "Backend service name"
  type        = string
  default     = "voice-app-webapp"
}

variable "service_port" {
  description = "Backend service port"
  type        = number
  default     = 80
}

# Create GCP Managed Certificate
resource "kubernetes_manifest" "managed_certificate" {
  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "ManagedCertificate"
    metadata = {
      name      = "${var.domain_name}-cert"
      namespace = var.namespace
    }
    spec = {
      domains = [
        var.domain_name,
        "www.${var.domain_name}"
      ]
    }
  }
}

# Create Frontend Config for HTTPS Redirect
resource "kubernetes_manifest" "frontend_config" {
  manifest = {
    apiVersion = "networking.gke.io/v1beta1"
    kind       = "FrontendConfig"
    metadata = {
      name      = "${var.domain_name}-frontend-config"
      namespace = var.namespace
    }
    spec = {
      redirectToHttps = {
        enabled          = true
        responseCodeName = "MOVED_PERMANENTLY_DEFAULT"
      }
    }
  }
}

# Update Ingress for HTTPS
resource "kubernetes_ingress_v1" "https_ingress" {
  metadata {
    name      = "voice-app-ingress"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/ingress.class"                 = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = var.static_ip
      "networking.gke.io/managed-certificates"      = kubernetes_manifest.managed_certificate.manifest.metadata.name
      "kubernetes.io/ingress.allow-http"           = "false"
      "networking.gke.io/v1beta1.FrontendConfig"   = kubernetes_manifest.frontend_config.manifest.metadata.name
    }
  }

  spec {
    rule {
      host = var.domain_name
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = var.service_name
              port {
                number = var.service_port
              }
            }
          }
        }
      }
    }

    rule {
      host = "www.${var.domain_name}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = var.service_name
              port {
                number = var.service_port
              }
            }
          }
        }
      }
    }
  }
}

# modules/gcp-https/outputs.tf
output "certificate_name" {
  description = "Name of the GCP managed certificate"
  value       = kubernetes_manifest.managed_certificate.manifest.metadata.name
}

output "ingress_name" {
  description = "Name of the created ingress"
  value       = kubernetes_ingress_v1.https_ingress.metadata[0].name
}
