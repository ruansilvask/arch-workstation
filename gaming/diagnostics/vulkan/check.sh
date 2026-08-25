#!/usr/bin/env bash
set -u
echo "=== Vulkan summary ==="
if command -v vulkaninfo >/dev/null 2>&1; then
  vulkaninfo --summary
else
  echo "vulkaninfo not installed"
  exit 1
fi
