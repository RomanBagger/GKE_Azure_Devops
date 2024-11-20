resource "helm_release" "nginx_ingress" {
  provider = helm

  name       = "nginx-ingress-controller"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress"
  create_namespace = true
  version = "4.0.17"
  
  values = [file("${path.module}/values.yaml")]
}
