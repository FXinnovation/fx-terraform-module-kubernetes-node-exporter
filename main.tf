#####
# Locals
#####

locals {
  labels = {
    "app.kubernetes.io/version"    = var.image_version
    "app.kubernetes.io/component"  = "exporter"
    "app.kubernetes.io/part-of"    = "monitoring"
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/name"       = "node-exporter"
  }
  port = 9100
}

#####
# Randoms
#####

resource "random_string" "selector" {
  special = false
  upper   = false
  numeric = false
  length  = 8
}

#####
# Daemonset
#####

resource "kubernetes_daemonset" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.daemonset_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.daemonset_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.daemonset_name
      },
      local.labels,
      var.labels,
      var.daemonset_labels
    )
  }

  spec {
    selector {
      match_labels = {
        app    = "node-exporter"
        random = random_string.selector.result
      }
    }

    template {
      metadata {
        annotations = merge(
          var.annotations,
          var.daemonset_annotations
        )
        labels = merge(
          {
            "app.kubernetes.io/instance" = var.daemonset_name
            app                          = "node-exporter"
            random                       = random_string.selector.result
          },
          local.labels,
          var.labels,
          var.daemonset_labels
        )
      }
      spec {
        dns_policy                       = "ClusterFirst"
        host_network                     = true
        host_pid                         = true
        restart_policy                   = "Always"
        termination_grace_period_seconds = 30

        toleration {
          operator = "Exists"
        }

        container {
          name              = "node-exporter"
          image             = "${var.image_name}:${var.image_version}"
          image_pull_policy = var.image_pull_policy

          args = [
            "--path.procfs=/host/proc",
            "--path.sysfs=/host/sys"
          ]

          port {
            container_port = local.port
            host_port      = local.port
            name           = "metrics"
            protocol       = "TCP"
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "30Mi"
            }
            limits = {
              cpu    = "200m"
              memory = "50Mi"
            }
          }

          volume_mount {
            mount_path = "/host/proc"
            name       = "proc"
            read_only  = true
          }

          volume_mount {
            mount_path = "/host/sys"
            name       = "sys"
            read_only  = true
          }
        }

        volume {
          name = "proc"
          host_path {
            path = "/proc"
          }
        }

        volume {
          name = "sys"
          host_path {
            path = "/sys"
          }
        }
      }
    }
  }
}
