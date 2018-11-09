resource "google_compute_instance_group" "lb" {
  name        = "lb"
  description = "LoadBalancer"

  instances = ["${google_compute_instance.app.*.self_link}"]

  named_port {
    name = "port"
    port = "9292"
  }

  zone = "${var.zone_app}"
}

resource "google_compute_http_health_check" "reddit-hc" {
  name               = "reddit-hc"
  request_path       = "/"
  port               = "9292"
  check_interval_sec = 5
  timeout_sec        = 3
}

resource "google_compute_backend_service" "reddit-back" {
  name          = "reddit-back"
  port_name     = "reddit-port"
  protocol      = "HTTP"
  timeout_sec   = 5
  health_checks = ["${google_compute_http_health_check.reddit-hc.self_link}"]

  backend {
    group = "${google_compute_instance_group.lb.self_link}"
  }
}

resource "google_compute_global_forwarding_rule" "reddit-rule" {
  name        = "reddit-rule"
  description = "reddit-rule"
  target      = "${google_compute_target_http_proxy.proxy.self_link}"
  port_range  = "80"
}

resource "google_compute_target_http_proxy" "proxy" {
  name        = "proxy"
  description = "proxy"
  url_map     = "${google_compute_url_map.url-map.self_link}"
}

resource "google_compute_url_map" "url-map" {
  name            = "url-map"
  description     = "url-map"
  default_service = "${google_compute_backend_service.reddit-back.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.reddit-back.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_service.reddit-back.self_link}"
    }
  }
}
