# modules/gke/variables.tf

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

variable "node_count" {
  description = "Number of nodes in the cluster"
  type        = number
}

variable "machine_type" {
  description = "Machine type for the nodes"
  type        = string
}

variable "create_cluster" {
  description = "Whether to create the GKE cluster"
  type        = bool
  default     = true
}

variable "disk_size_gb" {
  description = "Size of the disk attached to each node, specified in GB"
  type        = number
  default     = 25
}
