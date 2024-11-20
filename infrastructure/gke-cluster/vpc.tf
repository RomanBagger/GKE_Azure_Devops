resource "google_compute_network" "vpc" {
  name = var.vpc_name
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
  mtu = 1460
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = var.secondary_ip_range_1
  }
}

resource "google_compute_address" "address" {
  count  = var.nat_ips_count
  name   = "nat-manual-ip-${count.index}"
  region = var.region

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_router" "router" {
  name    = var.router_name
  network = google_compute_network.vpc.name
  bgp {
    asn               = 64514
  }
}

resource "google_compute_router_nat_address" "nat_address" {
  nat_ips = [google_compute_address.address[0].self_link, google_compute_address.address[1].self_link]
  router = google_compute_router.router.name
  router_nat = google_compute_router_nat.router_nat.name
  region = google_compute_router_nat.router_nat.region
}

resource "google_compute_router_nat" "router_nat" {
  name   = var.name_router_nat
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = [google_compute_address.address[0].self_link]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_firewall" "default" {
  name    = var.name_firewall
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22","1000-2000"]
  }

  source_ranges = [ "0.0.0.0/0" ]
  source_tags = ["web"]
}
