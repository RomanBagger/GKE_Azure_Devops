variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "Region where the GKE cluster will be created"
  type        = string
}

variable "location" {
  description = "Location for the GKE cluster"
  type        = string
}

variable "node_name" {
  description = "Name for the node pool"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the node pool"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "name_project" {
  description = "Google Cloud Project ID"
  type        = string
}