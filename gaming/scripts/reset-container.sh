#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="gaming"
GAME_PATH="${GAMING_GAME_PATH:-/mnt/jogos}"

echo "This operation removes only the Distrobox gaming container."
echo "Protected external library: ${GAME_PATH}"
echo "The script will NOT format or delete the game library."

if distrobox list 2>/dev/null | awk 'NR > 1 {print $2}' | grep -qx "${CONTAINER_NAME}"; then
  read -r -p "Type RESET-GAMING to continue: " confirmation
  [[ "${confirmation}" == "RESET-GAMING" ]] || {
    echo "Cancelled."
    exit 1
  }

  distrobox stop "${CONTAINER_NAME}" 2>/dev/null || true
  distrobox rm --force "${CONTAINER_NAME}"
  echo "Gaming container removed."
else
  echo "Gaming container does not exist."
fi
