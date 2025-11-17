provider "google" {
  project     = "sinuous-voice-476704-d4"
  region      = "us-central1"
  zone        = "us-central1-c"
}
resource "google_compute_instance" "python" {
  name         = "pythpnvm"
  machine_type = "e2-small"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker riya
    sudo chmod 666 /var/run/docker.sock
    sudo systemctl restart docker
    docker build -t python_img:latest .
    echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
    docker tag java_img:latest padmapriya26/python:v1
    docker push padmapriya26/python:v1
  EOF
}

