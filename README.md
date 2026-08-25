# Arch Workstation — Omarchy + Gaming

Reproducible post-install configuration for an Omarchy workstation with a
dedicated containerized Linux gaming environment.

## Important boundary

**Omarchy is installed separately.**

This repository starts after the first successful Omarchy boot. It does not
install Arch, Hyprland, Btrfs, systemd-boot, or the bootloader.

## Target architecture

```text
Omarchy
├── Arch base
├── Hyprland / Wayland
├── AMD RX 9060 XT
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
    ├── diagnóstico automático
    ├── remediação automática
    ├── compatibilidade por jogo
    └── instalação automática
```

## Safe workflow

1. Install the RX 9060 XT and PSU.
2. Install Omarchy from its official ISO.
3. Select only `/dev/nvme0n1` as the OS installation target.
4. Boot Omarchy.
5. Clone this repository.
6. Run:

```bash
./bootstrap/bootstrap.sh
```

The bootstrap performs a read-only preflight and then configures the
already-installed OS.

## Disk safety

The project never partitions, formats or wipes disks.

Known data disks:

```text
/dev/sda  -> OldHD
/dev/sdb  -> Jogos
/dev/sdc  -> Windows / Armazenamento
```

OS disk:

```text
/dev/nvme0n1
```

`/mnt/jogos` is persistent and is bind-mounted into the gaming container.
Resetting the container never deletes or formats that library.

## Gaming

The implementation follows the Distrobox approach used by AkitaOnRails'
`distrobox-gaming`, with the reference implementation retained under
`gaming/ansible/reference/`.

Steam credentials are never stored in this repository.
