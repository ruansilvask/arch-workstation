#!/usr/bin/env bash
set -u
echo "=== Proton / Steam compatibility tools ==="
distrobox enter gaming -- bash -lc '
  for d in \
    "$HOME/.steam/root/compatibilitytools.d" \
    "$HOME/.local/share/Steam/compatibilitytools.d"; do
    if [[ -d "$d" ]]; then
      find "$d" -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort
    fi
  done
'
