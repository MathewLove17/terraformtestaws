resource "kubernetes_namespace_v1" "crossplane" {
  metadata {
    name = "crossplane-system"
  }
}

resource "helm_release" "crossplane" {
  name      = "crossplane"
  namespace = kubernetes_namespace_v1.crossplane.metadata[0].name

  repository = "https://charts.crossplane.io/stable"
  chart      = "crossplane"
  version    = "1.15.0"

  values = [
    yamlencode({
      args = [
        "--enable-environment-configs"
      ]
    })
  ]
}
