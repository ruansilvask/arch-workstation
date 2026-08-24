# Architecture

## System layers

```text
+-----------------------------------------------------------+
|                        OMARCHY                            |
|                                                           |
|  Arch base                                                |
|  Hyprland / Wayland                                       |
|  systemd-boot                                             |
|  Btrfs                                                   |
|  PipeWire                                                 |
|  Bluetooth                                                |
|                                                           |
|  AMDGPU -> Mesa -> RADV -> Vulkan                         |
+-----------------------------+-----------------------------+
                              |
                              v
+-----------------------------------------------------------+
|                    ARCH-WORKSTATION                       |
|                                                           |
|  Zsh / shell tools                                        |
|  SSH / ssh-agent                                          |
|  Development tools                                        |
|  Desktop applications                                     |
|  Host validation                                          |
+-----------------------------+-----------------------------+
                              |
                              v
+-----------------------------------------------------------+
|                       GAMING                              |
|                                                           |
|  Distrobox container                                      |
|  Steam                                                     |
|  Proton                                                    |
|  DXVK / VKD3D                                              |
|  Gamescope                                                 |
|  MangoHud                                                  |
|  GameMode                                                  |
|  Protontricks                                              |
|  Compatibility data                                        |
|  Diagnostics + remediation                                 |
+-----------------------------+-----------------------------+
                              |
                              v
+-----------------------------------------------------------+
|                 PERSISTENT GAME STORAGE                   |
|                                                           |
|  /mnt/jogos                                                |
|  SteamLibrary                                              |
|                                                           |
|  Outside the container lifecycle.                         |
+-----------------------------------------------------------+
```

## GPU model

The GPU is physical hardware. The container does not virtualize the GPU and
does not install a second kernel driver.

The host owns:

```text
RX 9060 XT
    |
    v
AMDGPU
    |
    v
Mesa / RADV
    |
    v
Vulkan
```

The gaming container consumes the host graphics stack and exposes the required
device interfaces. This keeps the kernel driver and graphics device management
on the host while isolating user-space gaming software.

## Reproducibility

The host is configured declaratively. The Gaming container is disposable.

```text
Host configuration
        |
        +--> Gaming container
                 |
                 +--> Steam / Proton / tools
                 |
                 +--> external library
```

Destroying the container does not remove `/mnt/jogos`.

## Omarchy boundary

This repository does not replace the Omarchy installer. Omarchy is installed
first. This repository configures the resulting system.

The repository therefore treats Omarchy/Hyprland as the desktop target rather
than attempting to install KDE Plasma.

## Safety boundary

The installer validates the target disk before destructive operations. Data
disks are explicitly protected.

The Gaming module is never allowed to call `mkfs`, `fdisk`, `parted`, or
`wipefs` on game-storage devices.
