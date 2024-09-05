provider "google" {
  project = "kube-434706"
  region  = "us-central1"
  credentials = file("<path-to-service-account-key>.json")
}

# Create a GKE Cluster
resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "us-central1"

  node_pool {
    name       = "default-pool"
    node_count = 3

    node_config {
      machine_type = "n1-standard-1"
    }
  }
}

# Create a Managed Instance Group (MIG)
resource "google_compute_instance_template" "template" {
  name         = "instance-template"
  machine_type = "n1-standard-1"
  source_image = "projects/debian-cloud/global/images/family/debian-10"
}

resource "google_compute_instance_group_manager" "mig" {
  name               = "instance-group"
  base_instance_name = "instance"
  instance_template  = google_compute_instance_template.template.self_link
  target_size        = 2
  zone               = "us-central1-a"
}
