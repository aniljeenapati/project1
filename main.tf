resource "google_container_cluster" "primary_cluster" {
  name     = var.cluster_name
  location = var.region

  initial_node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 30
  }

  remove_default_node_pool = false
}
