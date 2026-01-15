resource "random_string" "this" {
  special = false
  upper   = false
  length  = 10
}

# Common config module: renders docker-compose.yaml
module "common" {
  source = "../common"

  dbx_proxy_image_version   = var.dbx_proxy_image_version
  dbx_proxy_health_port     = var.dbx_proxy_health_port
  dbx_proxy_listener        = var.dbx_proxy_listener
  dbx_proxy_max_connections = var.dbx_proxy_max_connections
}
