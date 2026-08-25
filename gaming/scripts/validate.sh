#!/usr/bin/env bash
set -u
p=0; f=0; w=0

ok(){ echo "[PASS] $1"; ((p++)); }
bad(){ echo "[FAIL] $1"; ((f++)); }
warn(){ echo "[WARN] $1"; ((w++)); }

lspci | grep -Ei 'VGA|3D|Display' | grep -Eqi 'AMD|ATI|Advanced Micro Devices' && ok "AMD GPU" || bad "AMD GPU"
command -v vulkaninfo >/dev/null && vulkaninfo --summary >/dev/null 2>&1 && ok "Host Vulkan" || bad "Host Vulkan"
command -v distrobox >/dev/null && ok "Distrobox" || bad "Distrobox"
distrobox list 2>/dev/null | awk 'NR > 1 {print $2}' | grep -qx gaming && ok "Gaming container" || bad "Gaming container"
distrobox enter gaming -- bash -lc 'command -v steam >/dev/null' && ok "Container Steam" || bad "Container Steam"
distrobox enter gaming -- bash -lc 'command -v gamescope >/dev/null' && ok "Container Gamescope" || bad "Container Gamescope"
distrobox enter gaming -- bash -lc 'command -v mangohud >/dev/null' && ok "Container MangoHud" || bad "Container MangoHud"
distrobox enter gaming -- bash -lc 'command -v protontricks >/dev/null' && ok "Container Protontricks" || warn "Container Protontricks"
[[ -d /mnt/jogos ]] && ok "/mnt/jogos exists" || warn "/mnt/jogos not mounted"
findmnt -rn /mnt/jogos >/dev/null 2>&1 && ok "/mnt/jogos mounted" || warn "/mnt/jogos not mounted"

echo "Gaming: $p passed / $f failed / $w warnings"
(( f == 0 ))
