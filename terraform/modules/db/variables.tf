variable public_key_path {
  description = "Path to the PUBLIC key used for ssh access"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base-20181104-125230"
}
