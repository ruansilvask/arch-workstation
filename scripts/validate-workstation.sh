#!/usr/bin/env bash
set -u

PASS=0
FAIL=0

check() {
  local label="$1"; shift
  if "$@"; then
    echo "[PASS] ${label}"
    PASS=$((PASS + 1))
  else
    echo "[FAIL] ${label}"
    FAIL=$((FAIL + 1))
  fi
}

check "Zsh installed" command -v zsh
check "Git installed" command -v git
check "SSH installed" command -v ssh
check "NetworkManager active" systemctl is-active --quiet NetworkManager.service
check "PipeWire active" systemctl --user is-active --quiet pipewire.service
check "WirePlumber active" systemctl --user is-active --quiet wireplumber.service
check "Bluetooth active" systemctl is-active --quiet bluetooth.service
check "Vulkan tools installed" command -v vulkaninfo
check "AMD Vulkan ICD installed" test -e /usr/share/vulkan/icd.d/radeon_icd.x86_64.json
check "Wayland session" test -n "${WAYLAND_DISPLAY:-}"
check "Btrfs root" bash -c 'findmnt -n -t btrfs / >/dev/null'
check "systemd-boot" bootctl is-installed

echo
echo "Workstation validation: ${PASS} passed / ${FAIL} failed"

(( FAIL == 0 ))
