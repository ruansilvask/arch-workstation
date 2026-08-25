#!/usr/bin/env bash
set -euo pipefail

if command -v paru >/dev/null 2>&1 || command -v yay >/dev/null 2>&1; then
  exit 0
fi

echo "No AUR helper detected. Installing paru from AUR."

sudo pacman -S --needed --noconfirm base-devel git

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

git clone https://aur.archlinux.org/paru.git "${tmp}/paru"
(
  cd "${tmp}/paru"
  makepkg -si --noconfirm
)

echo "AUR helper installed."
