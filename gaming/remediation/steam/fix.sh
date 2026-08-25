#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed steam
echo "Steam package ensured. Steam authentication remains user-controlled."
