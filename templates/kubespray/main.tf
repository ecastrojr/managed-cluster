module "cluster" {
  source = "github.com/getupcloud/terraform-cluster-kubespray?ref=v2.4"

  app_nodes               = var.app_nodes
  cluster_name            = var.name
  cluster_sla             = var.sla
  cronitor_api_key        = var.cronitor_api_key
  cronitor_pagerduty_key  = var.cronitor_pagerduty_key
  customer_name           = var.customer
  deploy_components       = var.deploy_components
  etc_hosts               = var.etc_hosts
  flux_git_repo           = var.flux_git_repo
  flux_wait               = var.flux_wait
  flux_version            = var.flux_version
  infra_nodes             = var.infra_nodes
  install_packages        = var.install_packages
  kubeconfig_filename     = var.kubeconfig_filename
  kubespray_git_ref       = var.kubespray_git_ref
  manifests_template_vars = local.manifests_template_vars
  master_nodes            = var.master_nodes
  ssh_private_key         = var.ssh_private_key
  ssh_user                = var.ssh_user
  ssh_password            = var.ssh_password
  uninstall_packages      = var.uninstall_packages
}
