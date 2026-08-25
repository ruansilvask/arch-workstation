#!/usr/bin/env bash
set -u
distrobox enter gaming -- bash -lc '
  for d in "$HOME/.steam/root/compatibilitytools.d" "$HOME/.local/share/Steam/compatibilitytools.d"; do
    [[ -d "$d" ]] && find "$d" -mindepth 1 -maxdepth 1 -type d -printf "%f\n"
  done
'
