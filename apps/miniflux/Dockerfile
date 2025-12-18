# syntax=docker/dockerfile:1

FROM ghcr.io/phongse/alpine:3.23.2@sha256:429d3b45169755ad17d38a9ff77ed32ed8e6eb7e99d9b6011888a6d2d4c0eb81
ARG TARGETARCH
ARG VERSION

ENV \
    LISTEN_ADDR=0.0.0.0:8080

COPY --chown=root:root --chmod=755 . /app
ADD --chown=root:root --chmod=755 "https://github.com/miniflux/v2/releases/download/${VERSION}/miniflux-linux-${TARGETARCH}" /app/bin/miniflux

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/app/bin/miniflux", "-healthcheck", "auto"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
