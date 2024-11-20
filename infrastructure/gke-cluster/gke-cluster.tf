resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

data "google_client_config" "default" {}

resource "google_container_cluster" "primary" {
  deletion_protection = false
  name     = var.cluster_name
  location = var.location

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count
  network = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link

  resource_labels = {
    environment = var.environment
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.location
  cluster    = var.cluster_name
  node_count = var.initial_node_count

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}