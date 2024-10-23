# variables.tf

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "voice-439010"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west1"
}

variable "zones" {
  description = "List of zones for the GKE cluster"
  type        = list(string)
  default     = ["europe-west1-b", "europe-west1-c", "europe-west1-d"]
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "europe-west1-b"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "voice-app-cluster"
}

variable "node_count" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "Size of the disk attached to each node"
  type        = number
  default     = 25
}

variable "chart_version" {
  description = "Version of the Helm chart"
  type        = string
  default     = "0.1.0"
}

variable "namespace" {
  description = "Kubernetes namespace for the voice app"
  type        = string
  default     = "voiceapp"
}

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "voice-app"
}

variable "chart_path" {
  description = "Path to the Helm chart"
  type        = string
  default     = "./Charts/voice-app-0.1.0.tgz"
}

variable "webapp_image" {
  description = "Docker image for the webapp"
  type        = string
  default     = "docker.io/abhikgho/text_to_speech_web_app:web-v1.0.3"
}

variable "worker_image" {
  description = "Docker image for the worker"
  type        = string
  default     = "docker.io/abhikgho/text_to_speech_web_app:worker-v1.0.3"
}

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

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "voicesapp.net"
}

variable "ingress_enabled" {
  description = "Whether to enable ingress"
  type        = bool
  default     = true
}

variable "create_ingress" {
  description = "Whether to create a separate ingress resource"
  type        = bool
  default     = false
}

variable "ingress_host" {
  description = "Hostname for the ingress"
  type        = string
  default     = "voicesapp.net"  # Same as domain_name
}