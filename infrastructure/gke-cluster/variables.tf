variable "cluster_name" {
  description = "Name of GKE cluster"
  type = string
}

variable "location" {
  description = "location of the cluster"
  type = string
}

variable "region" {
  description = "Name of region"
  type = string
}

variable "initial_node_count" {
  description = "Initial number of nodes in the cluster"
  type        = number
  default     = 2
}

variable "node_name" {
  description = "name-node-pool"
  type = string
}

variable "preemptible" {
  description = "Whether the nodes should be preemptible"
  type        = bool
  default     = true
}

variable "machine_type" {
  description = "type-and-size-of-machine"
  type = string
}

variable "environment" {
  description = "Environment type (dev, prod, etc.)"
  type        = string
}

variable "vpc_name" {
  description = "Name of VPC"
  type = string
}

variable "subnet_name" {
  description = "Name of subnet"
  type = string
  default = "cluster-subnet"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.2.0.0/16"
}

variable "secondary_ip_range_1" {
  description = "The first secondary IP range"
  type        = string
  default     = "192.168.10.0/24"
}

variable "nat_ips_count" {
  description = "The number of NAT IPs to create"
  type        = number
  default     = 2
}

variable "router_name" {
  description = "Name of router"
  type = string
  default = "router-for-gke"
}

variable "name_router_nat" {
  description = "Name of router_nat"
  type = string
  default = "router-nat-for-gke"
}

variable "name_firewall" {
  description = "Name of the firewall"
  type = string
  default = "firewall-cluster"
}

variable "name_project" {
  description = "Name of the project"
  type = string
}
