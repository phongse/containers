#!/usr/bin/env sh

exec \
    /app/bin/syncthing \
        --no-browser \
        --no-upgrade \
        "$@"
