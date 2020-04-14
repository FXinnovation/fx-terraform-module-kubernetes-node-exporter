#####
# Locals
#####

locals {
  labels = {
    "version"    = var.image_version
    "component"  = "exporter"
    "part-of"    = "monitoring"
    "managed-by" = "terraform"
    "name"       = "node-exporter"
  }
  port               = 9100
  grafana_dashboards = []
  prometheus_alert_groups_rules_labels = merge(
    {
      "source" = "https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-kubernetes-node-exporter"
    },
    var.prometheus_alert_groups_rules_labels
  )
  prometheus_alert_groups_rules_annotations = merge(
    {},
    var.prometheus_alert_groups_rules_annotations
  )
  prometheus_alert_groups = [
    {
      "name" = "node-exporter"
      "rules" = [
        {
          "alert" = "node-exporter - scrape collector failed"
          "expr"  = "node_scrape_collector_success < 1"
          "for"   = "2m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"              = "Node Exporter - Scraping failed on a collector"
              "description"          = "Node Exporter:\nScraping failed for collector {{ $labels.collector }} on {{ $labels.instance }}.\nLabels:\n{{ $labels }}"
              "description_html"     = "<h3>Node Exporter</h3><p>Scraping failed for collector {{ $labels.collector }} on {{ $labels.instance }}.</p><h4>Labels</h4><p>{{ $labels }}</p>"
              "description_markdown" = "### Node Exporter:\nScraping failed for collector {{ $labels.collector }} on {{ $labels.instance }}.\n#### Labels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        }
      ]
    },
    {
      "name"  = "node"
      "rules" = []
    }
  ]
}

#####
# Randoms
#####

resource "random_string" "selector" {
  special = false
  upper   = false
  number  = false
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
        instance = var.daemonset_name
      },
      local.labels,
      var.labels,
      var.daemonset_labels
    )
  }

  spec {
    selector {
      match_labels = {
        selector = "node-exporter-${random_string.selector.result}"
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
            instance = var.daemonset_name
            selector = "node-exporter-${random_string.selector.result}"
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
            host_port      = var.port
            name           = "http"
            protocol       = "TCP"
          }

          resources {
            requests {
              cpu    = "100m"
              memory = "30Mi"
            }
            limits {
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
