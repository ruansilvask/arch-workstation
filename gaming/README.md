# Gaming Environment

Reproducible Linux gaming environment for this workstation.

The design follows the Distrobox/container model used by the
[distrobox-gaming project by AkitaOnRails](https://github.com/akitaonrails/distrobox-gaming),
adapted for Omarchy + AMD.

## Stack

- Distrobox
- Podman
- Steam
- Valve Proton
- Protontricks
- DXVK/VKD3D support through Proton
- Gamescope
- MangoHud
- GameMode
- Vulkan tools
- automated diagnostics
- safe remediation
- per-game compatibility data

## Storage

Default external library:

```text
/mnt/jogos
```

The container is disposable. The game library is persistent.

`reset-container.sh` removes only the Distrobox container and its configuration.
It never formats, deletes, or recursively removes `/mnt/jogos`.

## Game installation

`data/install-games.yml` contains games selected for automatic installation.

Steam must be authenticated by the user. The installer does not store or
handle Steam credentials.

If a game already exists in the configured Steam library, the Steam client
should validate/reuse the existing content instead of blindly duplicating it.

## Compatibility

`data/game-overrides.yml` contains only explicit tested overrides.

The system prefers:

1. known per-game override
2. known compatibility recommendation
3. current stable Valve Proton
4. Proton Experimental as a controlled fallback

It does not blindly rotate through Proton versions.

## Validation

Run:

```bash
./gaming/scripts/validate.sh
```

Diagnostics:

```bash
./gaming/scripts/diagnose.sh
```

Rebuild the container:

```bash
./gaming/scripts/reset-container.sh
./gaming/scripts/install.sh
```


## Installation profiles

The default `bootstrap` profile installs only **ARK: Survival Evolved** (AppID 346110) so the Steam/Proton/Vulkan/BattlEye pipeline can be validated without downloading the complete library.

The `full` profile is intentionally separate and can be expanded after bootstrap validation.

## Idempotency

The gaming subsystem is idempotent, incremental and non-destructive. Re-running it reconciles the existing state. Existing games are reused and `/mnt/jogos` is never formatted or deleted by the automation.
