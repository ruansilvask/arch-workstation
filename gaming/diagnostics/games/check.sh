#!/usr/bin/env bash
set -u
echo "=== Game library ==="
if [[ -d /mnt/jogos ]]; then
  findmnt /mnt/jogos || true
  find /mnt/jogos -maxdepth 3 -type d -name steamapps -print 2>/dev/null | head -20
else
  echo "/mnt/jogos is not mounted"
  exit 1
fi
