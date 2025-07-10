target "docker-metadata-action" {}

variable "APP" {
  default = "ntfy"
}

variable "VERSION" {
  // renovate: datasource=github-releases depName=binwiederhier/ntfy
  default = "2.13.0"
}

variable "SOURCE" {
  default = "https://github.com/binwiederhier/ntfy"
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
