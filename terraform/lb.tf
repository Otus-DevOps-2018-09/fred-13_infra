resource "google_compute_instance_group" "apps-node-cluster" {
  name        = "apps-node-cluster"
  description = "Terraform instance group"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  named_port {
    name = "puma"
    port = "9292"
  }

  zone = "${var.zone_app}"
}

resource "google_compute_health_check" "reddit-servers-health" {
  name               = "reddit-servers-health"
  check_interval_sec = 5
  timeout_sec        = 5

  tcp_health_check {
    port = "9292"
  }
}

resource "google_compute_backend_service" "reddit-backend" {
  name                            = "reddit-backend"
  description                     = "Destinastion WEB"
  protocol                        = "HTTP"
  port_name                       = "puma"
  timeout_sec                     = 10
  connection_draining_timeout_sec = 10

  backend {
    group = "${google_compute_instance_group.apps-node-cluster.self_link}"
  }

  health_checks = ["${google_compute_health_check.reddit-servers-health.self_link}"]
}

resource "google_compute_url_map" "reddit_url" {
  name            = "reddit-url"
  default_service = "${google_compute_backend_service.reddit-backend.self_link}"
}

resource "google_compute_target_http_proxy" "reddit_proxy" {
  name    = "reddit-proxy"
  url_map = "${google_compute_url_map.reddit_url.self_link}"
}

resource "google_compute_global_forwarding_rule" "reddit_rule" {
  name       = "reddit-rule"
  target     = "${google_compute_target_http_proxy.reddit_proxy.self_link}"
  port_range = "80"
}
