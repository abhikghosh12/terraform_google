# variables.tf

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "voice-439010"
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

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "voicesapp.net"
}

variable "chart_path" {
  description = "Path to the Helm chart"
  type        = string
  default     = "./Charts/voice-app-0.1.0.tgz"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west10-a"
  
}