# Arch Workstation — Omarchy + Gaming

Reproducible workstation configuration for Omarchy, with a dedicated
containerized Linux gaming environment.

## Target architecture

```text
Omarchy
├── Arch base
├── Hyprland / Wayland
├── AMD Radeon RX 9060 XT
├── AMDGPU + Mesa/RADV
├── Btrfs
├── systemd-boot
├── PipeWire
├── Bluetooth
│
└── Gaming
    ├── Distrobox
    ├── Steam
    ├── Proton
    ├── DXVK
    ├── VKD3D
    ├── Gamescope
    ├── MangoHud
    ├── GameMode
    ├── automatic diagnostics
    ├── automatic remediation
    ├── per-game compatibility
    └── automatic installation
```

Omarchy is installed first. This repository configures the resulting system.

The project intentionally has no NVIDIA target and no KDE target.

## Safety

Only `/dev/nvme0n1` is considered the operating-system disk.

The following data disks are protected:

- `/dev/sda`
- `/dev/sdb`
- `/dev/sdc`

The Gaming module uses `/mnt/jogos` as persistent storage and never formats,
partitions, wipes, or recursively deletes that path.

## First execution

After installing Omarchy and booting into the graphical session:

```bash
git clone https://github.com/ruansilvask/arch-workstation.git
cd arch-workstation
git checkout develop
./bootstrap/bootstrap.sh
```

The bootstrap is intended to be idempotent.

Steam credentials are never stored in the repository. Game installation requires
an authenticated Steam session.

## Repository layout

```text
arch-workstation/
├── ansible/
├── bootstrap/
├── packages/
├── configs/
├── scripts/
├── docs/
└── gaming/
```
