# syntax=docker/dockerfile:1

ARG VERSION
FROM docker.io/library/alpine:${VERSION}

ARG \
    # renovate: datasource=repology depName=alpine_3_23/ca-certificates
    CA_CERTIFICATES_VERSION="20251003-r0" \
    # renovate: datasource=repology depName=alpine_3_23/catatonit
    CATATONIT_VERSION="0.2.1-r0" \
    # renovate: datasource=repology depName=alpine_3_23/curl
    CURL_VERSION="8.17.0-r1" \
    # renovate: datasource=repology depName=alpine_3_23/tzdata
    TZDATA_VERSION="2025b-r0"

RUN apk --no-cache --update --upgrade add \
    ca-certificates="${CA_CERTIFICATES_VERSION}" \
    catatonit="${CATATONIT_VERSION}" \
    curl="${CURL_VERSION}" \
    tzdata="${TZDATA_VERSION}"

USER nobody:nogroup
