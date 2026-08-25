#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

cd "$ROOT/ansible"
ansible-playbook ../gaming/ansible/host.yml
ansible-playbook ../gaming/ansible/container.yml
ansible-playbook ../gaming/ansible/steam.yml

echo
echo "Gaming environment created."
echo "Persistent library: /mnt/jogos"
echo "Steam authentication remains user-controlled."
