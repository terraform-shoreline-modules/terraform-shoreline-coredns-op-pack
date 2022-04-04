# Alarm that triggers when coredns latency exceeds the threshold
resource "shoreline_alarm" "coredns_latency_alarm" {
  name = "coredns_latency_alarm"
  description = "coredns request latency too high"
  # The query that triggers the alarm: is the coredns latency greater than threshold 30 times out of last 60 data points
  fire_query  = "(coredns_latency_ms > ${var.latency_threshold} | sum(60)) >= 30"
  # The query that ends the alarm: is the coredns latency lower than threshold 30 times out of last 60 data points
  clear_query =  "(coredns_latency_ms < ${var.latency_threshold} | sum(60)) > 30"
  # How often is the alarm evaluated. Default set at 60 seconds.
  check_interval_sec = "${var.check_interval}"
  # User-provided resource selection
  resource_query = "coredns_pods"

  # UI / CLI annotation informational messages:
  fire_title_template = "coredns request latency elevated"
  fire_short_template = "coredns request latency elevated"
  resolve_title_template = "coredns request latency ok"
  resolve_short_template = "coredns request latency ok"
  resource_type = "POD"

  compile_eligible = false

  # alarm is raised local to a resource (vs global)
  raise_for = "local"
  # fires when above the threshold
  condition_type = "above"
  # general type of alarm ("metric", "custom", or "system check")
  family = "custom"
  metric_name = "coredns_latency_ms"
  condition_value = "${var.latency_threshold}"

  enabled = true
}
