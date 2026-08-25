#!/usr/bin/env bash
set -euo pipefail
distrobox enter gaming -- bash -lc 'pacman -Syu --noconfirm'
