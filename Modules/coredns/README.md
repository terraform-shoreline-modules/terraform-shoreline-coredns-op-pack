# CoreDNS Op Pack Example

This document contains configuration and usage examples of the [CoreDNS Op Pack](https://github.com/terraform-shoreline-modules/terraform-shoreline-coredns-op-pack/tree/main/modules/coredns).

## Requirements

The following tools/configurations are required on the monitored resources, with appropriate permissions:

1. [CoreDNS metrics] (https://coredns.io/plugins/metrics/) in Prometheus


## Example

The following example monitors all pod resources with an k8s-app label of `kube-dns`. Whenever a targeted pod's coredns latency exceeds the `latency_threshold` of `20` milliseconds, Shoreline automatically triggers a rollout restart of the coredns pods.

```hcl
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
  url     = "<SHORELINE_CLUSTER_API_ENDPOINT>"
}

module "coredns" {
  # Location of the module
  source             = "terraform-shoreline-modules/coredns-op-pack/shoreline//modules/coredns"

  # Frequency to evaluate alarm conditions in seconds
  check_interval     = 60

  # Maximum dns latency, in milliseconds, before coredns pod rollout restart is triggered
  latency_threshold      = 20

  # Prefix to allow multiple instances of the module, with different params
  prefix             = ""

  # Resource query to select the affected resources
  resource_query     = "pod | namespace='kube-system' | k8s-app='kube-dns'"

}
```

## Manual command examples

These commands use Shoreline's expressive [Op language](https://docs.shoreline.io/op) to retrieve fleet-wide data using the generated actions from the CoreDNS module.

-> These commands can be executed within the [Shoreline CLI](https://docs.shoreline.io/installation#cli) or [Shoreline Notebooks](https://docs.shoreline.io/ui/notebooks).

### Manually check average latency on coredns pods over the last 60 seconds

```
op> pods | namespace="kube-system" | k8s-app="kube-dns" | coredns_latency_ms | window(60s) | mean(60)

 ID  | TYPE | NAME                                | REGION    | AZ         | TIMESTAMPS          | COREDNS_LATENCY_MS
 210 | POD  | kube-system.coredns-6968c9cbb-k7k68 | us-west-2 | us-west-2a | 2022/04/01 22:16:15 | 0.19
 212 | POD  | kube-system.coredns-6968c9cbb-pjbg9 | us-west-2 | us-west-2b | 2022/04/01 22:16:15 | 0.25
     |      |                                     |           |            |                     |
```

### Initiate rollout restart of coredns pods

```
op> host | pod | app='shoreline' | .container | limit=1 | rollout_restart_coredns
```

-> See the [shoreline_action resource](https://registry.terraform.io/providers/shorelinesoftware/shoreline/latest/docs/resources/action) and the [Shoreline Actions](https://docs.shoreline.io/actions) documentation for details.


### List triggered coredns alarms

```
op> events | alarm_name =~ 'coredns'

 RESOURCE_NAME                       | RESOURCE_TYPE | ALARM_NAME            | STATUS   | STEP_TYPE   | TIMESTAMP                 | DESCRIPTION
 kube-system.coredns-6968c9cbb-5xkr7 | POD           | coredns_latency_alarm | resolved |             |                           | coredns request latency too high
                                     |               |                       |          | ALARM_FIRE  | 2022-04-03T22:32:14-07:00 | coredns request latency elevated
                                     |               |                       |          | ALARM_CLEAR | 2022-04-03T22:32:27-07:00 | coredns request latency ok
```

-> See the [Shoreline Events documentation](https://docs.shoreline.io/op/events) for details.
