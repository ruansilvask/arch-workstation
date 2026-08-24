#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONTAINER_NAME="gaming"
GAME_PATH="${GAMING_GAME_PATH:-/mnt/jogos}"

if ! command -v distrobox >/dev/null 2>&1; then
  echo "ERROR: distrobox is not installed."
  exit 1
fi

if ! command -v podman >/dev/null 2>&1; then
  echo "ERROR: podman is not installed."
  exit 1
fi

# The game library is a protected external resource.
# This script may create a mount point but never formats/deletes it.
if [[ -e "${GAME_PATH}" ]]; then
  echo "Game library path: ${GAME_PATH}"
else
  echo "WARNING: ${GAME_PATH} does not exist yet."
fi

if ! distrobox list | awk 'NR > 1 {print $2}' | grep -qx "${CONTAINER_NAME}"; then
  echo "==> Creating gaming container"
  distrobox create \
    --name "${CONTAINER_NAME}" \
    --image archlinux:latest \
    --yes
else
  echo "==> Gaming container already exists"
fi

echo "==> Installing gaming packages inside container"
distrobox enter "${CONTAINER_NAME}" -- bash -lc '
  set -e
  pacman -Sy --noconfirm
  pacman -S --needed --noconfirm \
    steam \
    gamescope \
    mangohud \
    lib32-mangohud \
    gamemode \
    lib32-gamemode \
    protontricks \
    vulkan-tools \
    wine \
    winetricks \
    mesa \
    lib32-mesa \
    vulkan-radeon \
    lib32-vulkan-radeon \
    git \
    curl \
    jq
'

echo "==> Configuring external library"
if [[ -d "${GAME_PATH}" ]]; then
  distrobox enter "${CONTAINER_NAME}" -- bash -lc "
    mkdir -p '${GAME_PATH}'
  "
  echo "The external library is expected to be mounted by Distrobox integration."
else
  echo "Library not mounted; this is not fatal during initial setup."
fi

echo "==> Gaming container created."
echo "Authenticate Steam manually before automatic game installation."
echo "Run: gaming/scripts/validate.sh"
