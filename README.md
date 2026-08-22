# Arch Workstation

Reproducible Arch Linux workstation configuration.

The project is designed to rebuild the system from an Arch Linux installation environment and then configure the installed system using Ansible.

## Target Hardware

- CPU: AMD Ryzen 7 3700X
- GPU: NVIDIA GeForce GTX 1050 Ti
- RAM: 32 GB
- System SSD: Seagate FireCuda 520 500 GB
- Target disk: `/dev/nvme0n1`

## Operating System

- Arch Linux
- UEFI
- systemd-boot
- Linux LTS
- Btrfs
- KDE Plasma
- Wi-Fi
- PipeWire
- Bluetooth

## Storage

Only the system NVMe is managed by the installer.

### Managed

```text
/dev/nvme0n1
└── Seagate FireCuda 520
    ├── EFI System Partition
    └── Btrfs