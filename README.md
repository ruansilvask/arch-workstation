# Arch Workstation

Reproducible workstation configuration for **Omarchy**, the Arch-based Linux
distribution built around Hyprland/Wayland.

The repository is designed for a clean Omarchy installation followed by an
idempotent workstation bootstrap. It also contains a reproducible Gaming
environment based on Distrobox.

## Target

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
    └── automatic game installation
```

## Important storage rule

The system installer manages only `/dev/nvme0n1`.

The following disks are protected and must never be formatted, repartitioned,
or deleted by this repository:

- `/dev/sda`
- `/dev/sdb`
- `/dev/sdc`

The gaming environment may mount `/mnt/jogos`, but it must never format or
delete the game library.

## Operating model

1. Install Omarchy from its official ISO.
2. Boot the new system.
3. Clone this repository.
4. Run `./bootstrap/bootstrap.sh`.
5. The workstation configuration is applied.
6. The Gaming Distrobox is created and validated.
7. Selected games are installed through Steam after authentication.
8. If the container is damaged, `gaming/scripts/reset-container.sh` rebuilds it
   without touching the external game library.

No NVIDIA configuration is part of the target environment.

## Scope

This repository configures:

- Omarchy/Arch workstation
- AMD graphics stack
- Zsh and requested plugins
- SSH and ssh-agent
- development tools
- requested desktop applications
- Distrobox gaming environment
- Steam/Proton stack
- game compatibility data
- automatic validation and remediation
- selected game installation

The repository does not contain game binaries, Steam credentials, SSH private
keys, or secrets.
