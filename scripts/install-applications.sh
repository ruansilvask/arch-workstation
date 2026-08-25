#!/usr/bin/env bash
set -euo pipefail

# Core applications are installed from official Arch repositories whenever
# possible. AUR is only used when the requested application is not in the
# enabled official repositories.

OFFICIAL=(
  firefox
  bitwarden
  obsidian
  proton-vpn-gtk-app
  telegram-desktop
  vlc
)

sudo pacman -S --needed "${OFFICIAL[@]}"

# ONLYOFFICE is maintained as onlyoffice-bin in the AUR.
"${BASH_SOURCE[0]%/*}/install-aur-helper.sh"

AUR_HELPER=""
if command -v paru >/dev/null 2>&1; then
  AUR_HELPER=paru
elif command -v yay >/dev/null 2>&1; then
  AUR_HELPER=yay
fi

if [[ -n "${AUR_HELPER}" ]]; then
  "${AUR_HELPER}" -S --needed onlyoffice-bin
fi

# ChatGPT: no third-party desktop binary is trusted by this repository.
# Create a desktop shortcut to the official web application instead.
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

echo "Requested applications configured."
