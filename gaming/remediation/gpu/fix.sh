#!/usr/bin/env bash
set -euo pipefail

if ! lspci | grep -Eqi 'VGA|3D|Display' | grep -Eqi 'AMD|ATI|Advanced Micro Devices'; then
  echo "No AMD GPU detected. No automatic GPU remediation is safe."
  exit 1
fi

sudo pacman -S --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-tools
echo "AMD graphics userspace packages ensured."
