target "docker-metadata-action" {}

variable "APP" {
  default = "miniflux"
}

variable "VERSION" {
  // renovate: datasource=github-releases depName=miniflux/v2
  default = "2.2.12"
}

variable "SOURCE" {
  default = "https://github.com/miniflux/v2"
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
