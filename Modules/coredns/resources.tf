resource "shoreline_resource" "shoreline" {
  name        = "shoreline"
  description = "shoreline containers to run kubectl from"
  value       = "host | pod | app='shoreline' | .container"
}

resource "shoreline_resource" "coredns_pods" {
  name        = "coredns_pods"
  description = "coredns  pods"
  value       = "pod | namespace=\"kube-system\" | \"k8s-app\"=\"kube-dns\""
}
