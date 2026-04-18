target "docker-metadata-action" {}

variable "APP" {
  default = "alpine"
}

variable "VERSION" {
  // renovate: datasource=docker depName=docker.io/library/alpine
  default = "3.23.4"
}

variable "DIGEST" {
  default = "sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11"
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
