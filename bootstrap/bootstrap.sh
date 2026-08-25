#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ ! -d /sys/firmware/efi ]]; then
  echo "ERROR: UEFI boot required."
  exit 1
fi

echo "Checking target hardware..."
"${ROOT}/install/00-check-hardware.sh"

if [[ "${1:-}" == "--dry-run" ]]; then
  echo "Dry run complete."
  exit 0
fi

if [[ -f "${ROOT}/ansible/ansible.cfg" ]]; then
  cd "${ROOT}/ansible"
  ansible-galaxy collection install -r ../gaming/ansible/requirements.yml
  ansible-playbook site.yml
fi

echo "Configuring gaming environment..."
"${ROOT}/gaming/scripts/install.sh"

echo "Validating workstation..."
"${ROOT}/scripts/validate-workstation.sh"

echo "Validating gaming..."
"${ROOT}/gaming/scripts/validate.sh"

echo "Bootstrap complete."
