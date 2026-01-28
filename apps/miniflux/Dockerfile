# syntax=docker/dockerfile:1

FROM ghcr.io/phongse/alpine:3.23.3@sha256:6890365eb5363653f2716077bea4b26e04171fbb5dc5ad9f830c4d6c29c49b90
ARG TARGETARCH
ARG VERSION

ENV \
    LISTEN_ADDR=0.0.0.0:8080

COPY --chown=root:root --chmod=755 . /app
ADD --chown=root:root --chmod=755 "https://github.com/miniflux/v2/releases/download/${VERSION}/miniflux-linux-${TARGETARCH}" /app/bin/miniflux

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/app/bin/miniflux", "-healthcheck", "auto"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
