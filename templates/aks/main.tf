module "eks" {
  source = "github.com/getupcloud/terraform-cluster-aks?ref=main"

  cluster_name            = var.name
  cluster_sla             = var.sla
  cronitor_api_key        = var.cronitor_api_key
  cronitor_pagerduty_key  = var.cronitor_pagerduty_key
  customer_name           = var.customer
  flux_git_repo           = var.flux_git_repo
  flux_wait               = var.flux_wait
  flux_version            = var.flux_version
  manifests_template_vars = local.manifests_template_vars
  teleport_auth_token     = var.teleport_auth_token
  use_kubeconfig          = var.use_kubeconfig

  acr_name                                          = var.acr_name
  acr_resource_group_name                           = var.acr_resource_group_name
  acr_role_definition_name                          = var.acr_role_definition_name
  acr_skip_service_principal_aad_check              = var.acr_skip_service_principal_aad_check
  acr_subscription_id                               = var.acr_subscription_id
  admin_username                                    = var.admin_username
  allowed_maintenance_windows                       = var.allowed_maintenance_windows
  azure_modules                                     = var.azure_modules
  client_id                                         = var.client_id
  client_secret                                     = var.client_secret
  cluster_log_analytics_workspace_name              = var.cluster_log_analytics_workspace_name
  default_node_pool                                 = var.default_node_pool
  enable_azure_policy                               = var.enable_azure_policy
  enable_host_encryption                            = var.enable_host_encryption
  enable_http_application_routing                   = var.enable_http_application_routing
  enable_ingress_application_gateway                = var.enable_ingress_application_gateway
  enable_kube_dashboard                             = var.enable_kube_dashboard
  enable_log_analytics_workspace                    = var.enable_log_analytics_workspace
  enable_role_based_access_control                  = var.enable_role_based_access_control
  identity_type                                     = var.identity_type
  ingress_application_gateway_id                    = var.ingress_application_gateway_id
  ingress_application_gateway_name                  = var.ingress_application_gateway_name
  ingress_application_gateway_subnet_cidr           = var.ingress_application_gateway_subnet_cidr
  ingress_application_gateway_subnet_id             = var.ingress_application_gateway_subnet_id
  key_vault_secrets_provider                        = var.key_vault_secrets_provider
  key_vault_secrets_provider_enabled                = var.key_vault_secrets_provider_enabled
  kubernetes_version                                = var.kubernetes_version
  log_analytics_workspace_sku                       = var.log_analytics_workspace_sku
  log_retention_in_days                             = var.log_retention_in_days
  net_profile_dns_service_ip                        = var.net_profile_dns_service_ip
  net_profile_docker_bridge_cidr                    = var.net_profile_docker_bridge_cidr
  net_profile_outbound_type                         = var.net_profile_outbound_type
  net_profile_pod_cidr                              = var.net_profile_pod_cidr
  net_profile_service_cidr                          = var.net_profile_service_cidr
  network_mode                                      = var.network_mode
  network_plugin                                    = var.network_plugin
  network_policy                                    = var.network_policy
  node_pools                                        = var.node_pools
  node_resource_group                               = var.node_resource_group
  not_allowed_maintenance_windows                   = var.not_allowed_maintenance_windows
  orchestrator_version                              = var.orchestrator_version
  prefix                                            = var.prefix
  private_cluster_enabled                           = var.private_cluster_enabled
  private_dns_zone_enabled                          = var.private_dns_zone_enabled
  private_dns_zone_id                               = var.private_dns_zone_id
  private_dns_zone_name                             = var.private_dns_zone_name
  private_dns_zone_resource_group_name              = var.private_dns_zone_resource_group_name
  private_dns_zone_role_definition_name             = var.private_dns_zone_role_definition_name
  private_dns_zone_skip_service_principal_aad_check = var.private_dns_zone_skip_service_principal_aad_check
  private_dns_zone_subscription_id                  = var.private_dns_zone_subscription_id
  public_ssh_key                                    = var.public_ssh_key
  rbac_aad_admin_group_names                        = var.rbac_aad_admin_group_names
  rbac_aad_admin_group_object_ids                   = var.rbac_aad_admin_group_object_ids
  rbac_aad_client_app_id                            = var.rbac_aad_client_app_id
  rbac_aad_managed                                  = var.rbac_aad_managed
  rbac_aad_server_app_id                            = var.rbac_aad_server_app_id
  rbac_aad_server_app_secret                        = var.rbac_aad_server_app_secret
  resource_group_name                               = var.resource_group_name
  sku_tier                                          = var.sku_tier
  subscription_id                                   = var.subscription_id
  tags                                              = var.tags
  user_assigned_identity_id                         = var.user_assigned_identity_id
}
