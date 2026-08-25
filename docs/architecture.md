# Architecture

Omarchy owns the OS, Hyprland/Wayland, kernel, AMDGPU, Mesa/RADV, Btrfs,
systemd-boot, PipeWire and Bluetooth.

arch-workstation configures the workstation.

gaming creates a disposable Distrobox environment. The external game library
is persistent and outside the container lifecycle.

The NVIDIA driver is deliberately absent. The AMD kernel driver remains on the
host; the container consumes host graphics device interfaces and userspace
integration.
