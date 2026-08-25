#!/usr/bin/env bash
set -u
p=0; f=0
check() { if "$@"; then echo "[PASS] $1"; ((p++)); else echo "[FAIL] $1"; ((f++)); fi; }

check zsh command -v zsh
check git command -v git
check ssh command -v ssh
check vulkaninfo command -v vulkaninfo
check amd-vulkan test -e /usr/share/vulkan/icd.d/radeon_icd.x86_64.json
check btrfs-root findmnt -n -t btrfs /
check systemd-boot bootctl is-installed
check networkmanager systemctl is-active --quiet NetworkManager
check bluetooth systemctl is-active --quiet bluetooth
check pipewire systemctl --user is-active --quiet pipewire
check wireplumber systemctl --user is-active --quiet wireplumber

echo "Workstation: $p passed / $f failed"
(( f == 0 ))
