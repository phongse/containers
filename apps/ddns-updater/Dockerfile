# syntax=docker/dockerfile:1

FROM golang:1.24.3-alpine3.22 AS build
ARG TARGETARCH
ARG VERSION

ENV \
    CGO_ENABLED=0 \
    GOARCH=${TARGETARCH}

WORKDIR /tmp/gobuild

COPY . /app
RUN \
    apk --no-cache add \
        git=2.49.0-r0 \
    && git clone --single-branch --branch v${VERSION} --depth 1 https://github.com/qdm12/ddns-updater . \
    && git apply /app/patches/*.patch \
    && go build -trimpath -ldflags="-s -w \
        -X 'main.version=$VERSION' \
        -X 'main.date=$(date +"%Y-%m-%d")' \
        -X 'main.commit=PATCHED-BUILD' \
        " -o app cmd/ddns-updater/main.go \
    && rm -rf /app/patches/

FROM ghcr.io/phongse/alpine:3.22.0@sha256:130900fb71b3a12b0345432d380e42d5ac7da6709f67239e7305ddd3dc43405a

ENV \
    BACKUP_DIRECTORY=/config/backup \
    CONFIG_FILEPATH=/config/config.json \
    DATADIR=/config/data \
    HEALTH_SERVER_ADDRESS=127.0.0.1:9999

COPY --from=build --chown=root:root --chmod=755 /app /app
COPY --chown=root:root --chmod=755 --from=build /tmp/gobuild/app /app/bin/ddns-updater

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/app/bin/ddns-updater", "healthcheck"]

WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
