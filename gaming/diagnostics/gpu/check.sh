#!/usr/bin/env bash
set -u
echo "=== GPU ==="
lspci | grep -Ei 'VGA|3D|Display' || true
echo
echo "=== Kernel driver ==="
for card in /sys/class/drm/card*/device/driver; do
  [[ -e "$card" ]] && readlink -f "$card"
done
