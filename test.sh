#!/bin/bash
# Quick test with plasmoidviewer (doesn't require installation)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
plasmoidviewer -a "$SCRIPT_DIR" -f horizontal
