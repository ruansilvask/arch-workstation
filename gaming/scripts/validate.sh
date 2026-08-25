#!/usr/bin/env bash
set -u
p=0; f=0; w=0
ok(){ echo "[PASS] $1"; ((p++)); }
bad(){ echo "[FAIL] $1"; ((f++)); }
warn(){ echo "[WARN] $1"; ((w++)); }

lspci | grep -Ei 'VGA|3D|Display' | grep -Eqi 'AMD|ATI|Advanced Micro Devices' && ok "AMD GPU" || bad "AMD GPU"
command -v vulkaninfo >/dev/null && vulkaninfo --summary >/dev/null 2>&1 && ok "Vulkan" || bad "Vulkan"
command -v distrobox >/dev/null && ok "Distrobox" || bad "Distrobox"
distrobox list 2>/dev/null | awk 'NR > 1 {print $2}' | grep -qx gaming && ok "Gaming container" || bad "Gaming container"
command -v steam >/dev/null && ok "Steam" || bad "Steam"
command -v gamescope >/dev/null && ok "Gamescope" || bad "Gamescope"
command -v mangohud >/dev/null && ok "MangoHud" || bad "MangoHud"
command -v gamemoded >/dev/null && ok "GameMode" || warn "GameMode executable not found"
command -v protontricks >/dev/null && ok "Protontricks" || warn "Protontricks not found"
[[ -d /mnt/jogos ]] && ok "/mnt/jogos" || warn "/mnt/jogos not mounted"

echo "Gaming: $p passed / $f failed / $w warnings"
((f == 0))
