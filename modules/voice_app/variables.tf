# modules/voice_app/variables.tf

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

variable "cluster_endpoint" {
  description = "Endpoint for the GKE cluster"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "CA certificate for the GKE cluster"
  type        = string
  sensitive   = true
}
