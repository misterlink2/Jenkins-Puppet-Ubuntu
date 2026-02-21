terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.58"
    }
  }
}

locals {
  project = "jenkins-puppet"
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_firewall" "restricted_firewall" {
  name = "firewall-${local.project}"

  # Inbound: Ports 22 ONLY from my IP
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = var.allowed_ips
  }

 # Inbound: Ports 80, 443, 8000 open to any IP
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "8000"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # Outbound: Open to any IP on ports 22, 53, 80, 443, 8000
  rule {
    direction = "out"
    protocol  = "tcp"
    port      = "22"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol  = "tcp"
    port      = "80"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol  = "tcp"
    port      = "443"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol  = "tcp"
    port      = "8000"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol  = "udp"
    port      = "53"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_ssh_key" "my_key" {
  name       = "ssh-key-${local.project}"
  public_key = file(var.ssh_key_path)
}

resource "hcloud_server" "new_server" {
  name         = "server-${local.project}"
  image        = "ubuntu-22.04"
  server_type  = "cx23" # cpx22 can be used if cx23 is not available
  location     = var.location
  #user_data    = file("${path.module}/install_jenkins.sh")

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  firewall_ids = [hcloud_firewall.restricted_firewall.id]
  ssh_keys     = [hcloud_ssh_key.my_key.id]
}

output "new_server_ip" {
  value = hcloud_server.new_server.ipv4_address
}