# terraform-module-kubernetes-node-exporter

Terraform module to deploy the Prometheus node-exporter.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| kubernetes | >= 1.10.0 |
| random | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
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

## Outputs

| Name | Description |
|------|-------------|
| daemonset\_name | Name of the daemonset created by the module. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
