# syntax=docker/dockerfile:1

FROM ghcr.io/phongse/alpine:3.22.0@sha256:5dce726f33e47f79ee0d088246d121b6ecb413a9fec297edeb4651ff48e278fa
ARG TARGETARCH
ARG VERSION

ENV \
    LISTEN_ADDR=0.0.0.0:8080

COPY --chown=root:root --chmod=755 . /app
ADD --chown=root:root --chmod=755 "https://github.com/miniflux/v2/releases/download/${VERSION}/miniflux-linux-${TARGETARCH}" /app/bin/miniflux

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/app/bin/miniflux", "-healthcheck", "auto"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
