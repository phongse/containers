target "docker-metadata-action" {}

variable "APP" {
  default = "traefik"
}

variable "VERSION" {
  // renovate: datasource=github-releases depName=traefik/traefik
  default = "3.5.0"
}

variable "SOURCE" {
  default = "https://github.com/traefik/traefik"
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
