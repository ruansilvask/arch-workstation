#!/usr/bin/env bash
set -euo pipefail

TARGET_DISK="/dev/nvme0n1"
PROTECTED_DISKS=(/dev/sda /dev/sdb /dev/sdc)
PASS=0
FAIL=0

pass() { echo "[PASS] $1"; PASS=$((PASS + 1)); }
fail() { echo "[FAIL] $1"; FAIL=$((FAIL + 1)); }

echo "========================================"
echo "OMARCHY WORKSTATION HARDWARE CHECK"
echo "========================================"

[[ -d /sys/firmware/efi ]] && pass "UEFI mode" || fail "UEFI mode not detected"

CPU_MODEL="$(lscpu | awk -F: '/Model name/ {gsub(/^[ \t]+/, "", $2); print $2; exit}')"
echo "CPU: ${CPU_MODEL}"
[[ "${CPU_MODEL}" == *"Ryzen 7 3700X"* ]] && pass "Ryzen 7 3700X detected" || fail "Unexpected CPU"

MEMORY_GB="$(awk '/MemTotal/ {printf "%.0f", $2/1024/1024}' /proc/meminfo)"
(( MEMORY_GB >= 30 )) && pass "At least 30 GB RAM" || fail "Unexpected RAM: ${MEMORY_GB} GB"

if lspci | grep -Eqi 'VGA|3D|Display'; then
  GPU_LINES="$(lspci | grep -Ei 'VGA|3D|Display' || true)"
  echo "GPU:"
  echo "${GPU_LINES}"
  if echo "${GPU_LINES}" | grep -Eqi 'AMD|ATI|Advanced Micro Devices'; then
    pass "AMD graphics device detected"
  else
    fail "AMD graphics device not detected"
  fi
else
  fail "No graphics device detected"
fi

if [[ ! -b "${TARGET_DISK}" ]]; then
  fail "Target disk ${TARGET_DISK} does not exist"
else
  pass "Target disk ${TARGET_DISK} exists"
fi

echo
echo "Protected disks:"
for disk in "${PROTECTED_DISKS[@]}"; do
  if [[ -b "${disk}" ]]; then
    echo "  ${disk} $(lsblk -dn -o MODEL "${disk}" | xargs) $(lsblk -dn -o SIZE "${disk}" | xargs)"
    pass "${disk} protected"
  else
    echo "  ${disk} not present"
  fi
done

echo
lsblk -o NAME,SIZE,MODEL,FSTYPE,LABEL,MOUNTPOINTS

echo
echo "Passed: ${PASS}"
echo "Failed: ${FAIL}"

if (( FAIL > 0 )); then
  echo "Hardware validation failed. No installation should continue."
  exit 1
fi

echo "Hardware validation passed."
