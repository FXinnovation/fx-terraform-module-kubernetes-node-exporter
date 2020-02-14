output "daemonset_name" {
  description = "Name of the daemonset created by the module."
  value       = element(concat(kubernetes_daemonset.this.*.metadata.0.name, [""]), 0)
}
