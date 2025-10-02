# syntax=docker/dockerfile:1

ARG VERSION
FROM docker.io/library/alpine:${VERSION}

ARG \
    # renovate: datasource=repology depName=alpine_3_22/ca-certificates
    CA_CERTIFICATES_VERSION="20250911-r0" \
    # renovate: datasource=repology depName=alpine_3_22/catatonit
    CATATONIT_VERSION="0.2.1-r0" \
    # renovate: datasource=repology depName=alpine_3_22/curl
    CURL_VERSION="8.14.1-r1" \
    # renovate: datasource=repology depName=alpine_3_22/tzdata
    TZDATA_VERSION="2025b-r0"

RUN apk --no-cache --update --upgrade add \
    ca-certificates="${CA_CERTIFICATES_VERSION}" \
    catatonit="${CATATONIT_VERSION}" \
    curl="${CURL_VERSION}" \
    tzdata="${TZDATA_VERSION}"

USER nobody:nogroup
