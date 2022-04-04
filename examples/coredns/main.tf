terraform {
  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.1.3"
    }
  }
}

provider "shoreline" {
  # provider configuration here
  debug   = true
  retries = 2
}

module "coredns" {
  # Location of the module
  source            = "terraform-shoreline-modules/coredns-op-pack/shoreline//modules/coredns"

  # Frequency to evaluate alarm conditions in seconds
  check_interval    = 60

  # CoreDNS latency threshold in milliseconds
  latency_threshold = 20

  # Prefix to allow multiple instances of the module, with different params
  prefix            = ""

  # Resource query to select the affected resources
  resource_query    = "pods | namespace=\"kube-system\" | \"k8s-app\"=\"kube-dns\""

}
