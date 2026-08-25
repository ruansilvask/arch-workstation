#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
"$ROOT/install/00-check-hardware.sh"
"$ROOT/scripts/validate-workstation.sh"
"$ROOT/gaming/scripts/validate.sh"
