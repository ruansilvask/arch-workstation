# Omarchy installation boundary

This repository does not install Omarchy.

Install Omarchy first using the official ISO and boot into the new system.
Only after the first graphical login should this repository be executed.

Recommended sequence:

1. Install the RX 9060 XT and PSU.
2. Boot the official Omarchy ISO in UEFI mode.
3. Disable Secure Boot/TPM if required by the current Omarchy installer.
4. Select only `/dev/nvme0n1` as the OS installation target.
5. Let Omarchy create its own Btrfs/systemd-boot layout.
6. Boot Omarchy and complete the initial setup.
7. Clone this repository and run `./bootstrap/bootstrap.sh`.

The bootstrap is post-install configuration. It never calls pacstrap,
archinstall, mkfs, wipefs, fdisk, parted, or any partitioning tool.

Official manual:
https://omarchy.org/manual/getting-started/

Unattended installation documentation:
https://omarchy.org/manual/unattended-installs/

Akita's Omarchy 2.0 installation article:
https://akitaonrails.com/2025/08/29/new-omarchy-2-0-install/
