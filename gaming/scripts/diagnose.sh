#!/usr/bin/env bash
set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
status=0
for s in gpu vulkan steam proton games; do
  echo "===== $s ====="
  if ! "$ROOT/gaming/diagnostics/$s/check.sh"; then status=1; fi
  echo
done
exit "$status"
