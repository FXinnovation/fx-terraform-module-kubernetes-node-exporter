# terraform-module-kubernetes-node-exporter

Terraform module to deploy the Prometheus node-exporter.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| kubernetes | >= 1.10.0 |
| random | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | >= 1.10.0 |
| random | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| annotations | Additionnal annotations that will be merged on all resources. | `map` | `{}` | no |
| daemonset\_annotations | Additionnal annotations that will be merged on the daemonset. | `map` | `{}` | no |
| daemonset\_labels | Additionnal labels that will be merged on the daemonset. | `map` | `{}` | no |
| daemonset\_name | Name of the daemonset that will be create. | `string` | `"node-exporter"` | no |
| enabled | Whether or not to enable this module. | `bool` | `true` | no |
| image\_name | Name of the docker image to use. | `string` | `"prom/node-exporter"` | no |
| image\_pull\_policy | Image pull policy on the main container. | `string` | `"IfNotPresent"` | no |
| image\_version | Tag of the docker image to use. | `string` | `"v0.18.0"` | no |
| labels | Additionnal labels that will be merged on all resources. | `map` | `{}` | no |
| namespace | Namespace in which the module will be deployed. | `string` | `"kube-system"` | no |
| port | Node port on which the node-exporter will be listening on. | `number` | `9100` | no |
| prometheus\_alert\_groups\_rules\_annotations | Map of strings that will be merge on all prometheus alert groups rules annotations. | `map` | `{}` | no |
| prometheus\_alert\_groups\_rules\_labels | Map of strings that will be merge on all prometheus alert groups rules labels. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| daemonset\_annotations | Map of annotations that are configured on the daemonset. |
| daemonset\_labels | Map of labels that are configured on the daemonset. |
| daemonset\_name | Name of the daemonset created by the module. |
| daemonset\_template\_annotations | Map of annotations that are configured on the daemonset. |
| daemonset\_template\_labels | Map of labels that are configured on the daemonset. |
| grafana\_dashboards | List of strings representing grafana dashboards under the form of json strings. |
| image\_name | Name of the docker image used for the node-exporter container. |
| image\_pull\_policy | Image pull policy defined on the oracledb-exporter container. |
| image\_version | Tag of the docker image used for the node-exporter container. |
| namespace | Name of the namespace in which the resources have been deployed. |
| port | Port on which node-exporter is available on the node. |
| prometheus\_alert\_groups | List of object representing prometheus alert groups you can import in prometheus to alert you in case of problems. |
| selector\_labels | Map of the labels that are used as selectors. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
