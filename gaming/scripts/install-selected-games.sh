#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
command -v yq >/dev/null || { echo "Install yq first."; exit 1; }
command -v xdg-open >/dev/null || { echo "xdg-open not found."; exit 1; }

yq -r '.install_games[] | "\(.appid)\t\(.name)"' "$ROOT/gaming/data/install-games.yml" |
while IFS=$'\t' read -r appid name; do
  echo "Installing/selecting in Steam: $name ($appid)"
  xdg-open "steam://install/$appid" >/dev/null 2>&1 || true
  sleep 1
done
