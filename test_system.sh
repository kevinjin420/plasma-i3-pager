#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Try update first, fall back to install
if ! kpackagetool6 -t Plasma/Applet -u "$SCRIPT_DIR" 2>/dev/null; then
    kpackagetool6 -t Plasma/Applet -i "$SCRIPT_DIR"
fi

plasmashell --replace &
