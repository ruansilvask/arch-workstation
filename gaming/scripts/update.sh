#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="gaming"

if ! distrobox list | awk 'NR > 1 {print $2}' | grep -qx "${CONTAINER_NAME}"; then
  echo "Gaming container does not exist."
  exit 1
fi

distrobox enter "${CONTAINER_NAME}" -- bash -lc '
  pacman -Syu --noconfirm
'

echo "Gaming container updated."
