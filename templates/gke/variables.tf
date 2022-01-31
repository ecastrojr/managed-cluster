variable "get_kubeconfig_command" {
  description = "Command to create/update kubeconfig"
  type        = string
  default     = "true"
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "zones" {
  description = "GCP Zones"
  type        = list(string)
}

variable "node_pools" {
  description = "List of maps containing node pools"
  type        = list(map(string))
  default = [
    {
      "name" : "default-node-pool"
    }
  ]
}

variable "maintenance_exclusions" {
  description = "Description: List of maintenance exclusions. A cluster can have up to three"
  type        = list(object({ name = string, start_time = string, end_time = string }))
  default     = []
}

variable "maintenance_start_time" {
  description = "Time window specified for daily or recurring maintenance operations in RFC3339 format (Ex: 05:00)"
  type        = string
  default     = ""
}

variable "configure_ip_masq" {
  description = "Enables the installation of ip masquerading."
  type        = bool
  default     = false
}

variable "default_max_pods_per_node" {
  description = "The maximum number of pods to schedule per node."
  type        = number
  default     = 110
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to install."
  type        = string
  default     = "latest"
}

variable "release_channel" {
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`."
  type        = string
  default     = "STABLE"
}

variable "remove_default_node_pool" {
  description = "Remove the default node pool"
  type        = bool
  default     = false
}

variable "initial_node_count" {
  description = "The number of nodes to create in this cluster's default node pool."
  type        = number
  default     = 1
}

variable "cluster_autoscaling" {
  description = "Cluster autoscaling configuration"
  type = object({
    enabled       = bool
    min_cpu_cores = number
    max_cpu_cores = number
    min_memory_gb = number
    max_memory_gb = number
    gpu_resources = list(object({
      resource_type = string,
      minimum       = number,
      maximum       = number
    }))
  })
  default = {
    "enabled" : false,
    "gpu_resources" : [],
    "max_cpu_cores" : 0,
    "max_memory_gb" : 0,
    "min_cpu_cores" : 0,
    "min_memory_gb" : 0
  }
}

variable "grant_registry_access" {
  description = "Grants created cluster-specific service account storage.objectViewer and artifactregistry.reader roles."
  type        = bool
  default     = false
}

variable "service_account_key" {
  description = "Value of the keyfile for the service account to impersonate"
  type        = string
  default     = "/cluster/serviceaccount.json"
}
variable "horizontal_pod_autoscaling" {
  description = "Whether horizontal pod autoscaling enabled"
  type        = bool
  default     = true
}

variable "http_load_balancing" {
  description = "Whether http load balancing enabled"
  type        = bool
  default     = false
}

variable "ip_range_pods" {
  description = "The name of the secondary subnet ip range to use for pods"
  type        = string
  default     = ""
}

variable "ip_range_services" {
  description = "	The name of the secondary subnet range to use for services"
  type        = string
  default     = ""
}

variable "network" {
  description = "The VPC network to host the cluster in (required)"
  type        = string
}

variable "network_policy" {
  description = "Whether network policy enabled"
  type        = bool
  default     = false
}

variable "node_pools_oauth_scopes" {
  description = "Map of lists containing node oauth scopes by node-pool name"
  type        = map(list(string))
  default = {
    all   = ["https://www.googleapis.com/auth/cloud-platform"]
    app   = []
    infra = []
  }
}

variable "node_pools_labels" {
  description = "Map of maps containing node labels by node-pool name"
  type        = map(map(string))
  default = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }
}

variable "node_pools_metadata" {
  description = "Map of maps containing node metadata by node-pool name"
  type        = map(map(string))
  default = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }
}

variable "node_pools_taints" {
  description = "Map of lists containing node taints by node-pool name"
  type        = map(list(object({ key = string, value = string, effect = string })))
  default = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }
}

variable "node_pools_tags" {
  description = "Map of lists containing node network tags by node-pool name"
  type        = map(list(string))
  default = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in (required)"
  type        = string
}
