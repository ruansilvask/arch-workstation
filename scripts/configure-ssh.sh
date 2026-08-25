#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

install -d -m 700 "${HOME}/.ssh"
install -m 600 "${ROOT_DIR}/configs/ssh/config" "${HOME}/.ssh/config"

install -d -m 700 "${HOME}/.config/systemd/user"
install -m 644 \
  "${ROOT_DIR}/configs/systemd/user/ssh-agent.service" \
  "${HOME}/.config/systemd/user/ssh-agent.service"

systemctl --user daemon-reload
systemctl --user enable --now ssh-agent.service

if [[ -f "${HOME}/.ssh/id_ed25519" ]]; then
  export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
  ssh-add -q "${HOME}/.ssh/id_ed25519" 2>/dev/null || true
fi

chmod 700 "${HOME}/.ssh"
chmod 600 "${HOME}/.ssh/config"

echo "SSH configuration complete."
