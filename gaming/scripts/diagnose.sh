#!/usr/bin/env bash
set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATUS=0

run_check() {
  local label="$1"
  local script="$2"
  echo
  echo "========================================"
  echo "${label}"
  echo "========================================"
  if "${ROOT_DIR}/${script}"; then
    echo "[PASS] ${label}"
  else
    echo "[FAIL] ${label}"
    STATUS=1
  fi
}

run_check "GPU" gaming/diagnostics/gpu/check.sh
run_check "Vulkan" gaming/diagnostics/vulkan/check.sh
run_check "Steam" gaming/diagnostics/steam/check.sh
run_check "Proton" gaming/diagnostics/proton/check.sh
run_check "Game library" gaming/diagnostics/games/check.sh

exit "${STATUS}"
