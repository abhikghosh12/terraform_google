variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for the voice app"
  type        = string
}

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
}

variable "chart_path" {
  description = "Path to the Helm chart"
  type        = string
}

variable "webapp_image" {
  description = "Docker image for the webapp"
  type        = string
}

variable "worker_image" {
  description = "Docker image for the worker"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}

variable "google_client_access_token" {
  description = "Google client access token"
  type        = string
  sensitive   = true
}

variable "cluster_endpoint" {
  description = "GKE cluster endpoint"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "GKE cluster CA certificate"
  type        = string
  sensitive   = true
}

# ... existing variables ...

variable "ingress_host" {
  description = "Hostname for the ingress"
  type        = string
}

variable "ingress_enabled" {
  description = "Enable ingress"
  type        = bool
  default     = true
}
