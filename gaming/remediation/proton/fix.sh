#!/usr/bin/env bash
set -euo pipefail
distrobox enter gaming -- bash -lc 'mkdir -p "$HOME/.local/share/Steam/compatibilitytools.d" "$HOME/.steam/root/compatibilitytools.d"'
