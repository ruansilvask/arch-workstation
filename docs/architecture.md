# Architecture

```text
Official Omarchy ISO
        |
        v
Arch + Hyprland + Wayland + Btrfs + systemd-boot
        |
        v
arch-workstation bootstrap
        |
        +-- workstation packages
        +-- Zsh
        +-- SSH
        +-- desktop applications
        |
        v
gaming/
        |
        +-- AMD/Mesa/RADV host integration
        +-- Distrobox
        +-- Arch gaming container
        +-- Steam
        +-- Proton
        +-- DXVK/VKD3D via Proton
        +-- Gamescope
        +-- MangoHud
        +-- GameMode
        +-- diagnostics/remediation
        +-- game-specific configuration
```

The host keeps the kernel-level AMDGPU driver and the display/session stack.
The gaming container isolates the user-space gaming environment.

The repository does not install KDE and does not install NVIDIA drivers.

`/mnt/jogos` is outside the container lifecycle and is explicitly bind-mounted
into the gaming container.
