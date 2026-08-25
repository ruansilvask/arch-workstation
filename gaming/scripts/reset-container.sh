#!/usr/bin/env bash
set -euo pipefail
echo "Only the Distrobox container will be removed."
echo "The /mnt/jogos library will NOT be touched."
read -r -p 'Type RESET-GAMING to continue: ' c
[[ "$c" == RESET-GAMING ]] || exit 1
distrobox rm --force gaming 2>/dev/null || true
echo "Gaming container removed. Re-run gaming/scripts/install.sh to rebuild."
