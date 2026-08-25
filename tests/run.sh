#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Running host validation..."
"${ROOT_DIR}/install/00-check-hardware.sh"

echo
echo "Running workstation validation..."
"${ROOT_DIR}/scripts/validate-workstation.sh"

echo
echo "Running gaming validation..."
"${ROOT_DIR}/gaming/scripts/validate.sh"

echo
echo "All requested validation stages completed."
