provider "google" {
  region = "us-central1"
  project = "test"
}

resource "google_compute_instance" "my_instance" {
  zone = "us-central1-a"
  name = "test"

  machine_type = "e2-micro"
  network_interface {
    network = "default"
    access_config {}
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  scheduling {
    preemptible = true
  }

  guest_accelerator {
    type = "nvidia-tesla-t4" # <<<<<<<<<< Try changing this to nvidia-tesla-p4 to compare the costs
    count = 4
  }

  labels = {
    service = "web-app" 
    environment = "production"  
  }
}

resource "google_cloudfunctions_function" "my_function" {
  runtime = "nodejs20"
  name = "test"
  available_memory_mb = 512

  labels = {
    service = "web-app"  
    environment = "production" 
  }
}
