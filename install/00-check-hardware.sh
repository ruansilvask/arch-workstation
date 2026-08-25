#!/usr/bin/env bash
set -euo pipefail

echo "== Omarchy post-install preflight =="

[[ -d /sys/firmware/efi ]] || {
  echo "ERROR: system is not booted in UEFI mode."
  exit 1
}

ROOT_SOURCE="$(findmnt -no SOURCE / || true)"
ROOT_FSTYPE="$(findmnt -no FSTYPE / || true)"
echo "Root filesystem: ${ROOT_SOURCE:-unknown} (${ROOT_FSTYPE:-unknown})"

[[ "$ROOT_FSTYPE" == "btrfs" ]] || {
  echo "ERROR: Omarchy root filesystem is expected to be Btrfs."
  exit 1
}

bootctl is-installed >/dev/null 2>&1 || {
  echo "ERROR: systemd-boot is not installed."
  exit 1
}

GPU="$(lspci | grep -Ei 'VGA|3D|Display' || true)"
echo "GPU:"
echo "$GPU"
echo "$GPU" | grep -Eqi 'AMD|ATI|Advanced Micro Devices' || {
  echo "ERROR: AMD GPU not detected."
  exit 1
}

echo
echo "Protected data disks detected (read-only check):"
for d in /dev/sda /dev/sdb /dev/sdc; do
  [[ -b "$d" ]] && echo "  $d"
done

echo
echo "Game library:"
if findmnt -rn /mnt/jogos >/dev/null 2>&1; then
  findmnt /mnt/jogos
else
  echo "  /mnt/jogos is not mounted."
  echo "  This project will NOT format or mount it."
fi

echo
echo "Preflight passed. No disk operation was performed."
