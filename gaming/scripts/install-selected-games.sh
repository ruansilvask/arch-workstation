#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MANIFEST="${ROOT_DIR}/gaming/data/install-games.yml"

command -v yq >/dev/null 2>&1 || {
  echo "ERROR: yq is required to parse the game manifest."
  echo "Install it with: sudo pacman -S yq"
  exit 1
}

if ! command -v steam >/dev/null 2>&1; then
  echo "ERROR: Steam client is not installed on the host."
  exit 1
fi

echo "Selected games:"
yq -r '.install_games[] | "\(.appid)\t\(.name)"' "${MANIFEST}"

echo
echo "Steam must already be authenticated."
echo "The following steam://install/<AppID> URIs will be opened."
echo "Existing library content is left to Steam's own validation/reuse logic."

while IFS=$'\t' read -r appid name; do
  [[ -z "${appid}" ]] && continue
  echo "==> ${name} (${appid})"
  xdg-open "steam://install/${appid}" >/dev/null 2>&1 || true
  sleep 1
done < <(yq -r '.install_games[] | "\(.appid)\t\(.name)"' "${MANIFEST}")
