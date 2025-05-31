# syntax=docker/dockerfile:1

FROM ghcr.io/phongse/alpine:3.22.0@sha256:130900fb71b3a12b0345432d380e42d5ac7da6709f67239e7305ddd3dc43405a
ARG TARGETARCH
ARG VERSION

ENV \
    BACKUP_DIRECTORY=/config/backup \
    CONFIG_FILEPATH=/config/config.json \
    DATADIR=/config/data \
    HEALTH_SERVER_ADDRESS=127.0.0.1:9999

COPY --chown=root:root --chmod=755 . /app
ADD --chown=root:root --chmod=755 "https://github.com/qdm12/ddns-updater/releases/download/v${VERSION}/ddns-updater_${VERSION}_linux_${TARGETARCH}" /app/bin/ddns-updater

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/app/bin/ddns-updater", "healthcheck"]

WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
