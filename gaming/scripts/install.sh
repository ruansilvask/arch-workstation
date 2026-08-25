#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

cd "$ROOT/gaming/ansible"
ansible-galaxy collection install -r requirements.yml
ansible-playbook site.yml

echo
echo "Gaming environment created."
echo "Persistent library: /mnt/jogos"
echo "The container lifecycle never formats or deletes /mnt/jogos."
echo "Steam authentication remains user-controlled."
