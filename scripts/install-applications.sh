#!/usr/bin/env bash
set -euo pipefail

OFFICIAL=(
  firefox
  bitwarden
  obsidian
  telegram-desktop
  vlc
)

sudo pacman -S --needed --noconfirm "${OFFICIAL[@]}"

"${BASH_SOURCE[0]%/*}/install-aur-helper.sh"

AUR_HELPER=""
if command -v paru >/dev/null 2>&1; then
  AUR_HELPER=paru
elif command -v yay >/dev/null 2>&1; then
  AUR_HELPER=yay
fi

if [[ -n "${AUR_HELPER}" ]]; then
  "${AUR_HELPER}" -S --needed --noconfirm onlyoffice-bin proton-vpn-gtk-app
else
  echo "WARNING: No AUR helper available; ONLYOFFICE and Proton VPN were not installed."
fi

install -d "${HOME}/.local/share/applications"
cat > "${HOME}/.local/share/applications/chatgpt.desktop" <<'EOF'
[Desktop Entry]
Name=ChatGPT
Comment=Open ChatGPT
Exec=xdg-open https://chatgpt.com/
Icon=web-browser
Terminal=false
Type=Application
Categories=Network;Office;
EOF

echo "Desktop applications configured."
