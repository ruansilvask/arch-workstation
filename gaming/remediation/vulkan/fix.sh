#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-tools

if ! vulkaninfo --summary >/dev/null 2>&1; then
  echo "Vulkan still fails after package remediation."
  exit 1
fi

echo "Vulkan remediation successful."
