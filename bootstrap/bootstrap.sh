#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "== Omarchy post-install bootstrap =="
echo "This repository does NOT install or partition the operating system."

"${ROOT}/install/00-check-hardware.sh"

if [[ "${1:-}" == "--dry-run" ]]; then
  echo "Preflight complete. No changes made."
  exit 0
fi

command -v ansible-playbook >/dev/null 2>&1 || {
  echo "Ansible is not installed. Install it through the Omarchy/Arch package manager first."
  exit 1
}

cd "${ROOT}/ansible"
ansible-galaxy collection install -r ../gaming/ansible/requirements.yml
ansible-playbook site.yml

cd "${ROOT}"
"${ROOT}/scripts/install-applications.sh"
"${ROOT}/gaming/scripts/install.sh"

echo
echo "Validating workstation..."
"${ROOT}/scripts/validate-workstation.sh"

echo
echo "Validating gaming..."
"${ROOT}/gaming/scripts/validate.sh"

echo
echo "Bootstrap complete."
