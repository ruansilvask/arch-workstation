#!/usr/bin/env bash
set -u
[[ -d /mnt/jogos ]] || exit 1
findmnt /mnt/jogos || true
find /mnt/jogos -maxdepth 4 -type d -name steamapps -print 2>/dev/null | head -20
