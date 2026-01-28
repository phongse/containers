# syntax=docker/dockerfile:1

FROM ghcr.io/phongse/alpine:3.23.3@sha256:6890365eb5363653f2716077bea4b26e04171fbb5dc5ad9f830c4d6c29c49b90 AS build
ARG TARGETARCH
ARG VERSION

# hadolint ignore=DL3002
USER root

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN curl -fsSL "https://github.com/binwiederhier/ntfy/releases/download/v${VERSION}/ntfy_${VERSION}_linux_${TARGETARCH}.tar.gz" \
    | tar --strip-components=1 -xzf -

FROM ghcr.io/phongse/alpine:3.23.3@sha256:6890365eb5363653f2716077bea4b26e04171fbb5dc5ad9f830c4d6c29c49b90

ENV \
    NTFY_CONFIG_FILE=/config/server.yaml

COPY --chown=root:root --chmod=755 . /app
COPY --from=build --chown=root:root --chmod=755 /ntfy /app/bin/ntfy

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/usr/bin/curl", "-fkLs", "-o", "/dev/null", "http://localhost:2586/v1/health"]

WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
CMD ["serve"]
