target "docker-metadata-action" {}

variable "APP" {
  default = "alpine"
}

variable "VERSION" {
  // renovate: datasource=docker depName=docker.io/library/alpine
  default = "3.23.2"
}

variable "DIGEST" {
  default = "sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62"
}

variable "SOURCE" {
  default = "https://gitlab.alpinelinux.org/alpine/aports"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}@${DIGEST}"
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
