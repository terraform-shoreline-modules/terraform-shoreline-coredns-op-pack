resource "shoreline_metric" "coredns_dns_request_duration_seconds_sum" {
  name        = "coredns_dns_request_duration_seconds_sum"
  value       = "metric_query(metric_names=\"coredns_dns_request_duration_seconds_sum\", tags={\"server\":\"dns://:53\",\"type\":\"A\",\"zone\":\".\"})"
  description = ""
  resource_type = "POD"
}

resource "shoreline_metric" "coredns_dns_request_duration_seconds_count" {
  name        = "coredns_dns_request_duration_seconds_count"
  value       = "metric_query(metric_names=\"coredns_dns_request_duration_seconds_count\", tags={\"server\":\"dns://:53\",\"type\":\"A\",\"zone\":\".\"})"
  description = ""
  resource_type = "POD"
}

resource "shoreline_metric" "coredns_latency_ms" {
  name        = "coredns_latency_ms"
  value       = "coredns_dns_request_duration_seconds_sum/coredns_dns_request_duration_seconds_count * 1000"
  description = ""
  resource_type = "POD"
  units = "milliseconds"
}
