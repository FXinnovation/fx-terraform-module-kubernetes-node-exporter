#####
# Global
#####

variable "annotations" {
  description = "Additionnal annotations that will be merged on all resources."
  default     = {}
}

variable "enabled" {
  description = "Whether or not to enable this module."
  default     = true
}

variable "labels" {
  description = "Additionnal labels that will be merged on all resources."
  default     = {}
}

variable "namespace" {
  description = "Namespace in which the module will be deployed."
  default     = "kube-system"
}

#####
# Application
#####

variable "port" {
  description = "Node port on which the node-exporter will be listening on."
  default = 9100
}

#####
# Deployment
#####

variable "daemonset_annotations" {
  description = "Additionnal annotations that will be merged on the daemonset."
  default     = {}
}

variable "daemonset_labels" {
  description = "Additionnal labels that will be merged on the daemonset."
  default     = {}
}

variable "daemonset_name" {
  description = "Name of the daemonset that will be create."
  default     = "node-exporter"
}

variable "image_name" {
  description = "Name of the docker image to use."
  default     = "prom/node-exporter"
}

variable "image_pull_policy" {
  description = "Image pull policy on the main container."
  default     = "IfNotPresent"
}

variable "image_version" {
  description = "Tag of the docker image to use."
  default     = "v0.18.0"
}
