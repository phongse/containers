# syntax=docker/dockerfile:1

FROM ghcr.io/phongse/alpine:3.22.0@sha256:130900fb71b3a12b0345432d380e42d5ac7da6709f67239e7305ddd3dc43405a AS build
ARG TARGETARCH
ARG VERSION

# hadolint ignore=DL3002
USER root

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN curl -fsSL "https://github.com/syncthing/syncthing/releases/download/v${VERSION}/syncthing-linux-${TARGETARCH}-v${VERSION}.tar.gz" \
    | tar --strip-components=1 -xzf -

FROM ghcr.io/phongse/alpine:3.22.0@sha256:130900fb71b3a12b0345432d380e42d5ac7da6709f67239e7305ddd3dc43405a

ENV \
    STGUIADDRESS=0.0.0.0:8384 \
    STHOMEDIR=/config \
    STNODEFAULTFOLDER=1 \
    STNOUPGRADE=1 \
    XDG_STATE_HOME=/config

COPY --chown=root:root --chmod=755 . /app
COPY --from=build --chown=root:root --chmod=755 /syncthing /app/bin/syncthing

HEALTHCHECK --interval=10s --timeout=2s --start-period=10s CMD ["/usr/bin/curl", "-fkLs", "-o", "/dev/null", "http://localhost:8384/rest/noauth/health"]

WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/entrypoint.sh"]
