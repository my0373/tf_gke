variable "project_id" {
  description = "project id"
  type = string
}

variable "region" {
  description = "region"
  type = string
  default = "us-east1"
}

variable "resource_prefix" {
description = "prefix for all GCP resources created."
type = string
}
variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "machine_type" {
    default = "e2-medium"
    description = "Size of the nodes to use"
    type = string
}