#!/usr/bin/env bash
set -u
lspci | grep -Ei 'VGA|3D|Display' || true
echo
for d in /sys/class/drm/card*/device/driver; do
  [[ -e "$d" ]] && echo "$(readlink -f "$d")"
done
