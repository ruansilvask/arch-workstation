
### 2. `install/00-check-hardware.sh`

Esse é o arquivo mais importante da primeira etapa.

```bash
#!/usr/bin/env bash

set -euo pipefail

TARGET_DISK="/dev/nvme0n1"
EXPECTED_MODEL="Seagate FireCuda 520 SSD ZP500GM30002"

PROTECTED_DISKS=(
    "/dev/sda"
    "/dev/sdb"
    "/dev/sdc"
)

PASS=0
FAIL=0

pass() {
    echo "[PASS] $1"
    PASS=$((PASS + 1))
}

fail() {
    echo "[FAIL] $1"
    FAIL=$((FAIL + 1))
}

section() {
    echo
    echo "========================================"
    echo "$1"
    echo "========================================"
}

section "ARCH WORKSTATION HARDWARE CHECK"

echo "Date: $(date)"
echo "Hostname: $(hostname)"

section "BOOT MODE"

if [[ -d /sys/firmware/efi ]]; then
    pass "System booted in UEFI mode"
else
    fail "System is NOT booted in UEFI mode"
fi

section "CPU"

CPU_MODEL="$(lscpu | awk -F: '/Model name/ {gsub(/^[ \t]+/, "", $2); print $2; exit}')"

echo "Detected CPU: ${CPU_MODEL}"

if [[ "${CPU_MODEL}" == *"Ryzen 7 3700X"* ]]; then
    pass "AMD Ryzen 7 3700X detected"
else
    fail "Unexpected CPU"
fi

section "MEMORY"

MEMORY_GB="$(awk '/MemTotal/ {printf "%.0f", $2/1024/1024}' /proc/meminfo)"

echo "Detected memory: ${MEMORY_GB} GB"

if (( MEMORY_GB >= 30 )); then
    pass "At least 30 GB RAM detected"
else
    fail "Unexpected amount of RAM"
fi

section "GPU"

if lspci | grep -qi "NVIDIA.*GTX 1050 Ti"; then
    pass "NVIDIA GeForce GTX 1050 Ti detected"
else
    fail "NVIDIA GeForce GTX 1050 Ti not detected"
fi

section "TARGET DISK"

if [[ ! -b "${TARGET_DISK}" ]]; then
    fail "Target disk ${TARGET_DISK} does not exist"
else
    pass "Target disk ${TARGET_DISK} exists"

    MODEL="$(lsblk -dn -o MODEL "${TARGET_DISK}" | xargs)"

    echo "Detected disk model:"
    echo "  ${MODEL}"

    if [[ "${MODEL}" == "${EXPECTED_MODEL}" ]]; then
        pass "Target disk model matches expected hardware"
    else
        fail "Target disk model does NOT match expected hardware"
    fi
fi

section "PROTECTED DISKS"

for disk in "${PROTECTED_DISKS[@]}"; do
    if [[ -b "${disk}" ]]; then
        MODEL="$(lsblk -dn -o MODEL "${disk}" | xargs)"
        SIZE="$(lsblk -dn -o SIZE "${disk}" | xargs)"

        echo "[PROTECTED] ${disk}"
        echo "            Model: ${MODEL}"
        echo "            Size:  ${SIZE}"

        pass "${disk} detected and protected"
    else
        echo "[INFO] ${disk} not detected"
    fi
done

section "CURRENT BLOCK DEVICES"

lsblk -o NAME,SIZE,MODEL,FSTYPE,LABEL,MOUNTPOINTS

section "RESULT"

echo
echo "Checks passed: ${PASS}"
echo "Checks failed: ${FAIL}"

if (( FAIL > 0 )); then
    echo
    echo "SYSTEM VALIDATION FAILED"
    echo "Installation must NOT continue."
    exit 1
fi

echo
echo "SYSTEM VALIDATION PASSED"
echo
echo "Target disk:"
echo "  ${TARGET_DISK}"
echo "  ${EXPECTED_MODEL}"
echo
echo "Protected disks:"
printf '  %s\n' "${PROTECTED_DISKS[@]}"
echo
echo "No disks have been modified."
echo
echo "Hardware validation complete."