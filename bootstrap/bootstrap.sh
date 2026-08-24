#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Arch Workstation / Omarchy bootstrap"
echo "==> Repository: ${ROOT_DIR}"

if [[ ! -d /sys/firmware/efi ]]; then
  echo "ERROR: system is not booted in UEFI mode."
  exit 1
fi

if ! command -v omarchy >/dev/null 2>&1; then
  echo "WARNING: Omarchy CLI was not detected."
  echo "This repository is intended to run after a successful Omarchy install."
fi

"${ROOT_DIR}/install/00-check-hardware.sh"

if [[ "${1:-}" == "--dry-run" ]]; then
  echo "Dry run complete."
  exit 0
fi

echo "==> Installing workstation packages"
"${ROOT_DIR}/scripts/install-packages.sh"

echo "==> Configuring Zsh"
"${ROOT_DIR}/scripts/configure-zsh.sh"

echo "==> Configuring SSH"
"${ROOT_DIR}/scripts/configure-ssh.sh"

echo "==> Installing/configuring applications"
"${ROOT_DIR}/scripts/install-applications.sh"

echo "==> Configuring gaming"
"${ROOT_DIR}/gaming/scripts/install.sh"

echo "==> Running workstation validation"
"${ROOT_DIR}/scripts/validate-workstation.sh"

echo "==> Running gaming validation"
"${ROOT_DIR}/gaming/scripts/validate.sh"

echo
echo "========================================"
echo "WORKSTATION BOOTSTRAP COMPLETE"
echo "========================================"
