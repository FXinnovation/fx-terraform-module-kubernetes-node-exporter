output "daemonset_name" {
  description = "Name of the daemonset created by the module."
  value       = element(concat(kubernetes_daemonset.this.*.metadata.0.name, [""]), 0)
}

output "prometheus_alert_groups" {
  description = "List of object representing prometheus alert groups you can import in prometheus to alert you in case of problems."
  value       = var.enabled ? local.prometheus_alert_groups : []
}
