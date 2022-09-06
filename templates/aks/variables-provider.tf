# General settings
variable "resource_group_name" {
  type        = string
  description = "(Required) The resource group name to be used for the AKS deployment."
}

variable "node_resource_group" {
  type        = string
  description = "(Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

# Cluster settings
variable "kubernetes_version" {
  type        = string
  description = "(Optional) Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region."
  default     = null
}

variable "prefix" {
  type        = string
  description = "(Optional) The prefix for the resources created in the specified Azure Resource Group."
  default     = null
}

variable "dns_prefix" {
  type        = string
  description = "(Optional) The DNS prefix for the AKS deployment. This is used to create a unique FQDN for the cluster when it is created."
  default     = null
}

variable "private_cluster_enabled" {
  type        = bool
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
  default     = false
}

variable "private_dns_zone_id" {
  type        = string
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created."
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. When public_network_access_enabled is set to true, 0.0.0.0/32 must be added to api_server_authorized_ip_ranges"
  default     = true
}

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  description = "(Optional) The IP ranges to allow for incoming traffic to the server nodes."
  default     = ["0.0.0.0/32"]
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are 'Free' and 'Paid'."
  default     = "Free"
}

# Add-ons
variable "http_application_routing_enabled" {
  type        = bool
  description = "(Optional) Should HTTP Application Routing be enabled?"
  default     = false
}

variable "azure_policy_enabled" {
  type        = bool
  description = "(Optional) Should the Azure Policy Add-On be enabled? For more details please visit [Understand Azure Policy for Azure Kubernetes Service](https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks)"
  default     = false
}

# Linux profile settings
variable "admin_username" {
  type        = string
  description = "(Optional) The username of the local administrator to be created on the AKS deployment."
  default     = "azureadmin"
}

variable "public_ssh_key" {
  type        = string
  description = "(Optional) A custom SSH key to control access to the AKS deployment."
  default     = null
}

# RBAC settings
variable "enable_role_based_access_control" {
  type        = bool
  description = "(Optional) Enables Role Based Access Control."
  default     = false
}

variable "service_principal_enabled" {
  type        = bool
  description = "(Optional) Should the Azure Policy Add-On be enabled? For more details please visit [Understand Azure Policy for Azure Kubernetes Service](https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks)"
  default     = false
}

variable "rbac_aad_managed" {
  type        = bool
  description = "(Optional) If set to true, Azure will create/manage a Service Principal used for integration."
  default     = true
}

variable "rbac_aad_tenant_id" {
  type        = string
  description = "(Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used."
  default     = null
}

variable "client_id" {
  type        = string
  description = "(Optional) The Client ID (appId) for the Service Principal used for the AKS deployment."
  default     = null
}

variable "client_secret" {
  type        = string
  description = "(Optional) The Client Secret (password) for the Service Principal used for the AKS deployment."
  default     = null
}

variable "tenant_id" {
  type        = string
  description = "(Optional) The Tenant ID should be used. This can also be sourced from the ARM_TENANT_ID Environment Variable."
  default     = null
}

variable "rbac_aad_client_app_id" {
  type        = string
  description = "(Optional) The Client ID of an Azure Active Directory Application."
  default     = null
}

variable "rbac_aad_server_app_id" {
  type        = string
  description = "(Optional) The Application ID of an Azure Active Directory Application."
  default     = null
}

variable "rbac_aad_server_app_secret" {
  type        = string
  description = "(Optional) The Application Secret of an Azure Active Directory Application."
  default     = null
}

variable "rbac_aad_admin_group_object_ids" {
  type        = list(string)
  description = "(Optional) List of Object IDs that are granted admin access."
  default     = null
}

# Network settings
variable "node_vnet_resource_group" {
  type        = string
  description = "(Optional) Resource Group of vnet"
  default     = null
}

variable "network_plugin" {
  type        = string
  description = "(Optional) Network plugin to use for networking. Currently supported values are azure and kubenet. Changing this forces a new resource to be created."
  default     = "azure"
}

variable "network_policy" {
  type        = string
  description = " (Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are 'calico' and 'azure'. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_service_ip" {
  type        = string
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
  default     = null
}

variable "docker_bridge_cidr" {
  type        = string
  description = "(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
  default     = null
}

variable "outbound_type" {
  type        = string
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer."
  default     = "loadBalancer"
}

variable "pod_cidr" {
  description = " (Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "service_cidr" {
  type        = string
  description = "(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
  default     = null
}

variable "identity_type" {
  type        = string
  description = "(Optional) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
  default     = "SystemAssigned"
}

variable "identity_ids" {
  type        = list(string)
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned."
  default     = []
}

# Log analytics
variable "log_analytics_workspace_enabled" {
  type        = bool
  description = "(Optional) Enable the creation of a Log Analytics Workspace."
  default     = true
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "(Optional) If enabled, the name of the Log Analytics Workspace."
  default     = null
}

variable "log_analytics_workspace_sku" {
  type        = string
  description = "(Optional) The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018."
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  type        = number
  description = "(Optional) The retention period in days for logging in the Log Analytics Workspace."
  default     = 30
}

variable "log_analytics_solution_enabled" {
  type        = bool
  description = "(Optional) Enables the Log Analytics Solution for monitoring the Log Analytics Workspace."
  default     = false
}

# Application Gateway Ingress Controller
variable "ingress_application_gateway_enabled" {
  type        = bool
  description = "(Optional) Integrates Application Gateway Ingress Controller to this Kubernetes Cluster. Requires an existing Application Gateway."
  default     = false
}

variable "ingress_application_gateway_id" {
  type        = string
  description = "(Optional) The ID of the Application Gateway to integrate as Application Gateway Ingress Controller of this Kubernetes Cluster."
  default     = null
}

variable "ingress_application_gateway_name" {
  type        = string
  description = "(Optional) The name of the Application Gateway to be used or created in the Node Pool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
  default     = null
}

variable "ingress_application_gateway_subnet_cidr" {
  type        = string
  description = "(Optional) The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
  default     = null
}

variable "ingress_application_gateway_subnet_id" {
  type        = string
  description = "(Optional) The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster."
  default     = null
}

# Key Vault integration
variable "key_vault_secrets_provider_enabled" {
  type        = bool
  description = "(Optional) Enables the Key Vault Secret provider."
  default     = false
}

variable "key_vault_secrets_provider" {
  type = list(object({
    secret_rotation_enabled  = bool
    secret_rotation_interval = string
  }))
  description = "(Optional) A key_vault_secrets_provider block. For more details, please visit [Azure Keyvault Secrets Provider for AKS](https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver)."
  default = [
    {
      secret_rotation_enabled  = true
      secret_rotation_interval = "2m"
    }
  ]
}


# Maintenance windows
variable "allowed_maintenance_windows" {
  type = list(object({
    day   = string
    hours = list(number)
  }))
  description = "(Optional) List of allowed Maintenance Windows for AKS."
  default = [
    {
      day   = "Saturday"
      hours = [01]
    },
    {
      day   = "Sunday"
      hours = [01]
    }
  ]
}

variable "not_allowed_maintenance_windows" {
  type = list(object({
    start = string
    end   = string
  }))
  description = "(Optional) The start and end of a time span, formatted as an RFC3339 (2022-01-01T00:00:00Z) string."
  default     = []
}
