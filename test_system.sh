#!/bin/bash
# Install/update and restart plasmashell for system testing
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! kpackagetool6 -t Plasma/Applet -u "$SCRIPT_DIR" 2>/dev/null; then
    kpackagetool6 -t Plasma/Applet -i "$SCRIPT_DIR"
fi

plasmashell --replace &
