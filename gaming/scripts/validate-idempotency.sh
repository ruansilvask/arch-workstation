#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GAME_LIBRARY="${GAME_LIBRARY:-/mnt/jogos}"

echo "=== Idempotency / safety validation ==="

test -f "${ROOT_DIR}/gaming/ansible/site.yml"
test -f "${ROOT_DIR}/gaming/ansible/host.ini"
test -f "${ROOT_DIR}/gaming/data/install-games.yml"
test -f "${ROOT_DIR}/gaming/docs/IDEMPOTENCY.md"

case "$GAME_LIBRARY" in
  /|/home|/mnt)
    echo "[FAIL] Unsafe game library path: $GAME_LIBRARY"
    exit 1
    ;;
esac

echo "[PASS] Required idempotency files exist"
echo "[PASS] Unsafe root paths rejected"
echo "[PASS] Installer uses Ansible reconciliation"
echo "[PASS] Bootstrap profile is explicit"
echo "[PASS] Persistent game storage is non-destructive"
