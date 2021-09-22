#####
# Randoms
#####

resource "random_string" "default" {
  upper   = false
  number  = false
  special = false
  length  = 8
}

#####
# Datasources
#####

data "azurerm_kubernetes_cluster" "this" {
  name                = "prometheusplusplus-stg0"
  resource_group_name = "prometheusplusplus-stg0"
}

#####
# Context
#####

resource "kubernetes_namespace" "default" {
  metadata {
    name = random_string.default.result
  }
}

resource "kubernetes_namespace" "disabled" {
  metadata {
    name = random_string.disabled.result
  }
}

#####
# default example
#####

module "default" {
  source = "../.."

  namespace = kubernetes_namespace.default.metadata.0.name
}
