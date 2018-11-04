variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the PUBLIC key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to the PRIVITE key used for ssh access"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable count_instance {
  description = "Count instances"
  default     = 1
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base-20181104-123405"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base-20181104-125230"
}
