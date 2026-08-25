# Gaming

The Gaming module follows the Distrobox model used by AkitaOnRails'
`distrobox-gaming` project, adapted for Omarchy + AMD.

The original implementation is retained under `gaming/ansible/reference/`.

The active implementation focuses on:

- Omarchy/Hyprland/Wayland
- AMDGPU + Mesa/RADV
- Distrobox + Podman
- Steam
- Proton
- DXVK/VKD3D through Proton
- Gamescope
- MangoHud
- GameMode
- Protontricks
- automatic diagnostics
- safe remediation
- persistent `/mnt/jogos`
- selected-game installation

The first Steam authentication remains an explicit user action.
The project never stores Steam credentials.
