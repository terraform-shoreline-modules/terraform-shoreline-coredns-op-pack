# Action to perform rollout restart of coreddns pods.
# Note: if rollingUpdate strategy is included in the deployment then delete instead of rollout restart
resource "shoreline_action" "rollout_restart_coredns" {
  name = "rollout_restart_coredns"
  description = "restarts coredns pods in kube-system namespace"
  # Check deployment.yaml to determine if there is a rollingUpdate strategy
  # kubectl -n kube-system get deployment.apps/coredns -o yaml
  # If yes, then use following command:
  command = "`kubectl -n kube-system delete pod -l k8s-app=kube-dns`"
  # If no, then use following command:
  # command = "`kubectl rollout restart -n kube-system deployment/coredns`"
  resource_query = "shoreline | limit=1"
  # Select the shell to run 'command' with.
  shell = "/bin/bash"
  # timeout in milliseconds
  timeout = 60000

  # UI / CLI annotation informational messages:
  start_short_template    = "Starting rollout restart of coredns pods"
  error_short_template    = "Error rollout restart of coredns pods"
  complete_short_template = "Finished rollout restart of coredns pods"
  start_long_template     = "Starting rollout restart of coredns pods"
  error_long_template     = "Error rollout restart of coredns pods"
  complete_long_template  = "Finished rollout restart of coredns pods"

  enabled = true
}
