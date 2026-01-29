# syntax=docker/dockerfile:1

FROM golang:1.25.6-alpine3.23@sha256:98e6cffc31ccc44c7c15d83df1d69891efee8115a5bb7ede2bf30a38af3e3c92 AS build
ARG TARGETARCH
ARG VERSION
ARG \
    # renovate: datasource=repology depName=alpine_3_23/git
    GIT_VERSION="2.52.0-r0"

ENV \
    CGO_ENABLED=0 \
    GOARCH=${TARGETARCH}

WORKDIR /tmp/gobuild

COPY . /app
RUN \
    apk --no-cache add \
        git="${GIT_VERSION}" \
    && git clone --single-branch --branch v${VERSION} --depth 1 https://github.com/qdm12/ddns-updater . \
    && git apply /app/patches/*.patch \
    && go build -trimpath -ldflags="-s -w \
        -X 'main.version=$VERSION' \
        -X 'main.date=$(date +"%Y-%m-%d")' \
        " -o app cmd/ddns-updater/main.go \
    && rm -rf /app/patches/

FROM ghcr.io/phongse/alpine:3.23.3@sha256:6890365eb5363653f2716077bea4b26e04171fbb5dc5ad9f830c4d6c29c49b90

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
