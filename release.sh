#!/bin/bash
set -euo pipefail

read -rp "Major release? [y/N] " reply
case "$reply" in
    [yY]*) major=true ;;
    *) major=false ;;
esac

gh workflow run release.yml -f major="$major"
