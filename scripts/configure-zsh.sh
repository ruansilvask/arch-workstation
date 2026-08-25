#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${HOME}/.zshrc"

install -d -m 700 "${HOME}/.config/zsh"
install -m 644 "${ROOT_DIR}/configs/zsh/.zshrc" "${TARGET}"

if ! grep -q '^export ZDOTDIR=' "${HOME}/.zshenv" 2>/dev/null; then
  :
fi

if [[ "${SHELL:-}" != "/usr/bin/zsh" ]]; then
  chsh -s /usr/bin/zsh
fi

mkdir -p "${HOME}/.nvm"

if [[ ! -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]]; then
  echo "SDKMAN is not initialized yet; install it manually with the official installer when desired."
fi

echo "Zsh configured."
