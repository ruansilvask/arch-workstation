#!/usr/bin/env bash
set -euo pipefail

distrobox enter gaming -- bash -lc '
  mkdir -p "$HOME/.local/share/Steam/compatibilitytools.d"
  mkdir -p "$HOME/.steam/root/compatibilitytools.d"
'
echo "Proton compatibility-tool directories ensured."
