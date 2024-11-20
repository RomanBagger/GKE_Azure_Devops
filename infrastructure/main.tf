provider "helm" {
  kubernetes {
    host  = "https://${module.gke-cluster.kubernetes_cluster_endpoint}"
    token = module.gke-cluster.kubernetes_access_token
    cluster_ca_certificate = base64decode(module.gke-cluster.kubernetes_cluster_ca_certificate)
  }
}

module "gke-cluster" {
  source = "./gke-cluster"

  cluster_name = var.cluster_name
  region       = var.region
  location     = var.location
  node_name    = var.node_name
  machine_type = var.machine_type
  environment  = var.environment
  vpc_name     = var.vpc_name
  name_project = var.name_project
}

module "nginx-controller" {
  source = "./nginx-controller"

  gke_cluster_endpoint = module.gke-cluster.kubernetes_cluster_endpoint
  gke_access_token     = module.gke-cluster.kubernetes_access_token
  gke_cluster_ca_cert  = module.gke-cluster.kubernetes_cluster_ca_certificate
}