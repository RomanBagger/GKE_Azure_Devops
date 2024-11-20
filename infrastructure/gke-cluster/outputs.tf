output "kubernetes_cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = google_container_cluster.primary.endpoint
}

output "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = var.cluster_name
}

output "kubernetes_cluster_ca_certificate" {
  description = "The base64 encoded CA certificate for the Kubernetes cluster"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}

output "kubernetes_access_token" {
  description = "The access token to authenticate with the Kubernetes cluster"
  value       = data.google_client_config.default.access_token
}