#!/usr/bin/env bash
set -u

PASS=0
FAIL=0
WARN=0

pass() { echo "[PASS] $1"; PASS=$((PASS + 1)); }
fail() { echo "[FAIL] $1"; FAIL=$((FAIL + 1)); }
warn() { echo "[WARN] $1"; WARN=$((WARN + 1)); }

if lspci | grep -Eqi 'VGA|3D|Display' | grep -Eqi 'AMD|ATI|Advanced Micro Devices'; then
  pass "AMD GPU detected"
else
  fail "AMD GPU detected"
fi

if command -v vulkaninfo >/dev/null 2>&1 && vulkaninfo --summary >/dev/null 2>&1; then
  pass "Vulkan functional"
else
  fail "Vulkan functional"
fi

if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
  pass "Wayland session detected"
else
  warn "Wayland session not detected; run validation from the graphical session"
fi

if systemctl --user is-active --quiet pipewire.service; then
  pass "PipeWire active"
else
  fail "PipeWire active"
fi

if command -v distrobox >/dev/null 2>&1; then
  pass "Distrobox installed"
else
  fail "Distrobox installed"
fi

if distrobox list 2>/dev/null | awk 'NR > 1 {print $2}' | grep -qx gaming; then
  pass "Gaming container exists"
else
  fail "Gaming container exists"
fi

if distrobox list 2>/dev/null | awk 'NR > 1 {print $2}' | grep -qx gaming; then
  if distrobox enter gaming -- steam --version >/dev/null 2>&1; then
    pass "Steam runtime"
  else
    fail "Steam runtime"
  fi
fi

if command -v gamescope >/dev/null 2>&1; then
  pass "Gamescope installed"
else
  fail "Gamescope installed"
fi

if command -v mangohud >/dev/null 2>&1; then
  pass "MangoHud installed"
else
  fail "MangoHud installed"
fi

if command -v gamemoded >/dev/null 2>&1; then
  pass "GameMode installed"
else
  warn "GameMode executable not found"
fi

if command -v protontricks >/dev/null 2>&1; then
  pass "Protontricks installed"
else
  warn "Protontricks not found on host"
fi

if [[ -d /mnt/jogos ]]; then
  pass "/mnt/jogos exists"
else
  warn "/mnt/jogos not mounted yet"
fi

echo
echo "Gaming validation: ${PASS} passed / ${FAIL} failed / ${WARN} warnings"

(( FAIL == 0 ))
