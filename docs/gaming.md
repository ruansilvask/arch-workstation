# Gaming

The gaming environment is based on the Distrobox model used by the
`distrobox-gaming` project from AkitaOnRails, adapted for this workstation.

## Host

The host provides:

- AMDGPU
- Mesa/RADV
- Vulkan
- Wayland
- PipeWire
- input devices
- `/dev/dri`

## Container

The container provides:

- Steam
- Proton
- DXVK/VKD3D tooling
- Gamescope
- MangoHud
- GameMode
- Protontricks
- diagnostics and compatibility tooling

The container is disposable.

## Game storage

The external game library is configured through:

```text
/mnt/jogos
```

The module never formats the game disk.

## Game policy

`data/priority-games.yml` identifies games that are important to the user.

`data/install-games.yml` identifies games to install automatically.

`data/game-overrides.yml` is the place for tested, per-game Proton or launch
option overrides.

No override is invented merely because a game exists. Unknown games use the
default Proton policy until a tested recommendation is available.

## Validation policy

Validation is performed in layers:

1. GPU
2. Vulkan
3. Wayland
4. PipeWire
5. Distrobox
6. Steam
7. Proton
8. Gamescope
9. MangoHud
10. Protontricks
11. external game library
12. selected game metadata

If a known remediation is safe, it is attempted automatically. Otherwise the
diagnostic reports a blocker and the operator is asked to intervene.
