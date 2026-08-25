#!/usr/bin/env bash
set -euo pipefail
sudo pacman -S --needed mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-tools
vulkaninfo --summary >/dev/null
