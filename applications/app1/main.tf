provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "app1" {
  name       = "app1"
  chart      = "${path.module}/helm_chart"
  namespace  = "default"

  values = [
    file("${path.module}/helm_chart/values.yaml")
  ]
}