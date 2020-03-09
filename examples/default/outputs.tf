output "prometheus_alert_groups" {
  description = "List of maps representing prometheus alert groups."
  value       = module.default.prometheus_alert_groups
}
