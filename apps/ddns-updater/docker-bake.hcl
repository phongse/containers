target "docker-metadata-action" {}

variable "APP" {
  default = "ddns-updater"
}

variable "VERSION" {
  // renovate: datasource=github-releases depName=qdm12/ddns-updater
  default = "2.9.0"
}

variable "SOURCE" {
  default = "https://github.com/qdm12/ddns-updater"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
