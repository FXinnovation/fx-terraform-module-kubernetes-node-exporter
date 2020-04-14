#####
# Global
#####

output "selector_labels" {
  description = "Map of the labels that are used as selectors."
  value       = element(concat(kubernetes_daemonset.this.*.spec.0.selector, [{}]), 0)
}

output "port" {
  description = "Port on which node-exporter is available on the node."
  value       = var.enabled ? var.port : ""
}

output "image_name" {
  description = "Name of the docker image used for the node-exporter container."
  value       = var.enabled ? var.image_name : ""
}

output "image_version" {
  description = "Tag of the docker image used for the node-exporter container."
  value       = var.enabled ? var.image_version : ""
}

output "image_pull_policy" {
  description = "Image pull policy defined on the oracledb-exporter container."
  value       = var.enabled ? var.image_pull_policy : ""
}

output "grafana_dashboards" {
  description = "List of strings representing grafana dashboards under the form of json strings."
  value       = var.enabled ? local.grafana_dashboards : []
}

output "prometheus_alert_groups" {
  description = "List of object representing prometheus alert groups you can import in prometheus to alert you in case of problems."
  value       = var.enabled ? local.prometheus_alert_groups : []
}

#####
# Daemonset
#####

output "daemonset_name" {
  description = "Name of the daemonset created by the module."
  value       = element(concat(kubernetes_daemonset.this.*.metadata.0.name, [""]), 0)
}

output "daemonset_annotations" {
  description = "Map of annotations that are configured on the daemonset."
  value       = element(concat(kubernetes_daemonset.this.*.metadata.0.annotations, [{}]), 0)
}

output "daemonset_labels" {
  description = "Map of labels that are configured on the daemonset."
  value       = element(concat(kubernetes_daemonset.this.*.metadata.0.labels, [{}]), 0)
}

output "daemonset_template_annotations" {
  description = "Map of annotations that are configured on the daemonset."
  value       = element(concat(kubernetes_daemonset.this.*.spec.0.template.0.metadata.0.annotations, [{}]), 0)
}

output "daemonset_template_labels" {
  description = "Map of labels that are configured on the daemonset."
  value       = element(concat(kubernetes_daemonset.this.*.spec.0.template.0.metadata.0.labels, [{}]), 0)
}

#####
# Namespace
#####

output "namespace" {
  description = "Name of the namespace in which the resources have been deployed."
  value       = element(concat(kubernetes_daemonset.this.*.metadata.0.namespace, [""]), 0)
}
