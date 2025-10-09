target "docker-metadata-action" {}

variable "APP" {
  default = "alpine"
}

variable "VERSION" {
  // renovate: datasource=docker depName=docker.io/library/alpine
  default = "3.22.2"
}

variable "DIGEST" {
  default = "sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412"
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
