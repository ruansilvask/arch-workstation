#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v pacman >/dev/null 2>&1; then
  echo "ERROR: pacman not found."
  exit 1
fi

sudo pacman -Syu --needed

install_list() {
  local file="$1"
  mapfile -t packages < <(
    grep -vE '^[[:space:]]*(#|$)' "${file}" |
      awk '{$1=$1};1'
  )
  ((${#packages[@]})) && sudo pacman -S --needed "${packages[@]}"
}

install_list "${ROOT_DIR}/packages/base.txt"
install_list "${ROOT_DIR}/packages/workstation.txt"
install_list "${ROOT_DIR}/packages/gaming-host.txt"

sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service

systemctl --user enable --now pipewire.service pipewire-pulse.service wireplumber.service 2>/dev/null || true

echo "Package installation complete."
