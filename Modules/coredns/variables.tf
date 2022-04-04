# The API url for your shoreline cluster, i.e. "https://<customer>.<region>.api.shoreline-<cluster>.io"
provider "shoreline" {
  #url = "https://test.us.api.shoreline-test12.io"
}

variable "check_interval" {
  type        = number
  description = "Frequency, in seconds, to check coredns latency."
  default     = 60
}

variable "latency_threshold" {
  type        = number
  description = "coredns latency threshold in milliseconds."
  default     = 20.0
}
