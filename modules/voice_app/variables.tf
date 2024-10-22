# modules/voice_app/variables.tf

# GCP-related variables
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

# Kubernetes-related variables
variable "namespace" {
  description = "Kubernetes namespace for the voice app"
  type        = string
}

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
}

# Helm chart variables
variable "chart_path" {
  description = "Path to the Helm chart"
  type        = string
}

variable "chart_version" {
  description = "Version of the Helm chart"
  type        = string
  default     = "0.1.0"
}

# Image variables
variable "webapp_image" {
  description = "Docker image for the webapp"
  type        = string
}

variable "worker_image" {
  description = "Docker image for the worker"
  type        = string
}

variable "webapp_image_tag" {
  description = "Docker image tag for the webapp"
  type        = string
  default     = "latest"
}

variable "worker_image_tag" {
  description = "Docker image tag for the worker"
  type        = string
  default     = "latest"
}

# Replica counts
variable "webapp_replica_count" {
  description = "Number of replicas for the webapp"
  type        = number
  default     = 1
}

variable "worker_replica_count" {
  description = "Number of replicas for the worker"
  type        = number
  default     = 1
}

# Storage variables
variable "uploads_storage_size" {
  description = "Storage size for uploads PVC"
  type        = string
  default     = "5Gi"
}

variable "output_storage_size" {
  description = "Storage size for output PVC"
  type        = string
  default     = "5Gi"
}

variable "redis_master_storage_size" {
  description = "Storage size for Redis master PVC"
  type        = string
  default     = "5Gi"
}

variable "redis_replicas_storage_size" {
  description = "Storage size for Redis replicas PVC"
  type        = string
  default     = "5Gi"
}

# Ingress variables
variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}

variable "ingress_enabled" {
  description = "Whether to enable ingress"
  type        = bool
  default     = true
}

variable "ingress_host" {
  description = "Hostname for the ingress"
  type        = string
}

variable "create_ingress" {
  description = "Whether to create a separate ingress resource"
  type        = bool
  default     = false
}

# Authentication variables
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

# Redis configuration
variable "redis_enabled" {
  description = "Whether to enable Redis"
  type        = bool
  default     = true
}

variable "redis_replica_count" {
  description = "Number of Redis replicas"
  type        = number
  default     = 2
}

variable "redis_auth_enabled" {
  description = "Whether to enable Redis authentication"
  type        = bool
  default     = false
}