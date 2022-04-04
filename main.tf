# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these parameters/secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# SHORELINE_URL   - The API url for your shoreline cluster, i.e. "https://<customer>.<region>.api.shoreline-<cluster>.io"
# SHORELINE_TOKEN - The alphanumeric access token for your cluster. (Typically from Okta.)

terraform {
  # Setting 0.13.1 as the minimum version. Older versions are missing significant features.
  required_version = ">= 0.13.1"

  #required_providers {
  #  shoreline = {
  #    source  = "shorelinesoftware/shoreline"
  #    version = ">= 1.1.0"
  #  }
  #}
}

# Example instantiation of the CoreDns Op Pack:
module "coredns_example" {
  source             = "./modules/coredns/"
#  prefix             = "coredns_"
#  check_interval     = 60
#  resource_query     = "pod | namespace='kube-system' | k8s-app='kube-dns'"
}
