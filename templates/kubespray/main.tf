module "cluster" {
  source = "github.com/getupcloud/terraform-cluster-kubespray?ref=v3.0.0-alpha7"

  # cluster basics
  customer_name    = var.customer_name
  cluster_name     = var.cluster_name
  cluster_sla      = var.cluster_sla
  cluster_provider = var.cluster_provider
  use_kubeconfig   = var.use_kubeconfig
  pre_create       = var.pre_create
  post_create      = var.post_create
  modules          = var.modules
  dump_debug       = var.dump_debug

  # monitoring and operations
  cronitor_enabled            = var.cronitor_enabled
  cronitor_pagerduty_key      = var.cronitor_pagerduty_key
  cronitor_notification_lists = var.cronitor_notification_lists
  opsgenie_enabled            = var.opsgenie_enabled
  teleport_auth_token         = var.teleport_auth_token

  # flux
  flux_git_repo           = var.flux_git_repo
  flux_wait               = var.flux_wait
  flux_version            = var.flux_version
  manifests_template_vars = local.manifests_template_vars

  # provider specific
  api_endpoint        = var.api_endpoint
  app_nodes           = var.app_nodes
  deploy_components   = var.deploy_components
  etc_hosts           = var.etc_hosts
  infra_nodes         = var.infra_nodes
  install_packages    = var.install_packages
  kubeconfig_filename = var.kubeconfig_filename
  kubespray_git_ref   = var.kubespray_git_ref
  master_nodes        = var.master_nodes
  region              = var.region
  ssh_private_key     = var.ssh_private_key
  ssh_user            = var.ssh_user
  ssh_password        = var.ssh_password
  systemctl_enable    = var.systemctl_enable
  systemctl_disable   = var.systemctl_disable
  uninstall_packages  = var.uninstall_packages
}
