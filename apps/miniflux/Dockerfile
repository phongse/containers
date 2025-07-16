# syntax=docker/dockerfile:1

FROM ghcr.io/phongse/alpine:3.22.1@sha256:3281146614b408ff6cf18f1a1f799f2312be31561c04442a2fbff09fe6ac39c5
ARG TARGETARCH
ARG VERSION

ENV \
    LISTEN_ADDR=0.0.0.0:8080

COPY --chown=root:root --chmod=755 . /app
ADD --chown=root:root --chmod=755 "https://github.com/miniflux/v2/releases/download/${VERSION}/miniflux-linux-${TARGETARCH}" /app/bin/miniflux

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/app/bin/miniflux", "-healthcheck", "auto"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
