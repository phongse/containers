#!/usr/bin/env sh

exec \
    /app/bin/syncthing \
        --no-browser \
        --no-default-folder \
        --no-upgrade \
        "$@"
