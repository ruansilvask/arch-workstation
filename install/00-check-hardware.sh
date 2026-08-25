#!/usr/bin/env bash
set -euo pipefail

TARGET=/dev/nvme0n1
PROTECTED=(/dev/sda /dev/sdb /dev/sdc)

[[ -d /sys/firmware/efi ]] || { echo "UEFI not detected"; exit 1; }
[[ -b "$TARGET" ]] || { echo "$TARGET not found"; exit 1; }

GPU="$(lspci | grep -Ei 'VGA|3D|Display' || true)"
echo "$GPU"
echo "$GPU" | grep -Eqi 'AMD|ATI|Advanced Micro Devices' ||
  { echo "AMD GPU not detected"; exit 1; }

echo "Target disk: $TARGET"
echo "Protected disks:"
for d in "${PROTECTED[@]}"; do
  [[ -b "$d" ]] && echo "  PROTECTED: $d"
done

lsblk -o NAME,SIZE,FSTYPE,LABEL,MOUNTPOINTS
