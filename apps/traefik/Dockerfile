# syntax=docker/dockerfile:1

FROM ghcr.io/phongse/alpine:3.22.2@sha256:7f57cb600282f668c115e2a4e3646b3cded418a5e69fc8eeb3f8db886348c09d AS build
ARG TARGETARCH
ARG VERSION

# hadolint ignore=DL3002
USER root

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN curl -fsSL "https://github.com/traefik/traefik/releases/download/v${VERSION}/traefik_v${VERSION}_linux_${TARGETARCH}.tar.gz" \
    | tar -xzf -

FROM ghcr.io/phongse/alpine:3.22.2@sha256:7f57cb600282f668c115e2a4e3646b3cded418a5e69fc8eeb3f8db886348c09d

COPY --chown=root:root --chmod=755 . /app
COPY --from=build --chown=root:root --chmod=755 /traefik /app/bin/traefik

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/usr/bin/curl", "-fkLs", "-o", "/dev/null", "http://localhost:8080/ping"]

WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
