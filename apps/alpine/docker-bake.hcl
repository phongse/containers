target "docker-metadata-action" {}

variable "APP" {
  default = "alpine"
}

variable "VERSION" {
  // renovate: datasource=docker depName=docker.io/library/alpine
  default = "3.23.0"
}

variable "DIGEST" {
  default = "sha256:51183f2cfa6320055da30872f211093f9ff1d3cf06f39a0bdb212314c5dc7375"
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
