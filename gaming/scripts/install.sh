#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PROFILE="${1:---profile=bootstrap}"

case "$PROFILE" in
  --profile=bootstrap|bootstrap) PROFILE_NAME="bootstrap" ;;
  --profile=full|full) PROFILE_NAME="full" ;;
  *) echo "Usage: $0 [--profile=bootstrap|--profile=full]"; exit 2 ;;
esac

echo "=== Gaming installer ==="
echo "Profile: ${PROFILE_NAME}"
echo "Policy: idempotent / incremental / non-destructive"

GAME_LIBRARY="${GAME_LIBRARY:-/mnt/jogos}"
if [[ -e "$GAME_LIBRARY" ]]; then
  echo "[OK] Persistent game library exists: $GAME_LIBRARY"
else
  echo "[INFO] $GAME_LIBRARY does not exist."
  echo "[INFO] No filesystem will be formatted or created automatically."
fi

command -v ansible-playbook >/dev/null 2>&1 || {
  echo "[ERROR] ansible-playbook is required."
  exit 1
}

ansible-playbook   -i "${ROOT_DIR}/gaming/ansible/host.ini"   "${ROOT_DIR}/gaming/ansible/site.yml"   -e "gaming_profile=${PROFILE_NAME}"   -e "game_library=${GAME_LIBRARY}"
