# syntax=docker/dockerfile:1

FROM ghcr.io/phongse/alpine:3.23.3@sha256:3171610fd6565bc32d04c0c80fa5a378a0d5b43ced9586c543b06741862797d6
ARG TARGETARCH
ARG VERSION

ENV \
    LISTEN_ADDR=0.0.0.0:8080

COPY --chown=root:root --chmod=755 . /app
ADD --chown=root:root --chmod=755 "https://github.com/miniflux/v2/releases/download/${VERSION}/miniflux-linux-${TARGETARCH}" /app/bin/miniflux

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/app/bin/miniflux", "-healthcheck", "auto"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
