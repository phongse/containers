#!/usr/bin/env sh

if [ ! -f "${NTFY_CONFIG_FILE}" ]; then
    mkdir -p "${NTFY_CONFIG_FILE%/*}"
    cp /app/defaults/server.yaml "${NTFY_CONFIG_FILE}"
fi

exec \
    /app/bin/ntfy \
        "$@"
