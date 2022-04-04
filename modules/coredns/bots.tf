# Bot that fires the rollout restart action when the coredns latency exceeds the threshold.
resource "shoreline_bot" "dns_latecy_restart_bot" {
  name        = "dns_latecy_restart_bot"
  description = "Restart coredns pods"
  command     = "if ${shoreline_alarm.coredns_latency_alarm.name} then ${shoreline_action.rollout_restart_coredns.name} fi"

  # general type of bot this can be "standard" or "custom"
  family = "custom"

  enabled     = true
}
