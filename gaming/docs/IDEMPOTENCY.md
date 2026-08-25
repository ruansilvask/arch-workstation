# Idempotency and safety contract

The gaming subsystem is explicitly idempotent, incremental and non-destructive.

- Existing packages are detected before installation.
- Existing Distrobox containers are reused.
- Existing configuration is reconciled instead of blindly overwritten.
- Existing Steam games are detected by AppID and are not downloaded again.
- The persistent game library is preserved.
- `/mnt/jogos` is never formatted, partitioned, deleted or recursively cleaned.
- Recreating the gaming container must not delete `/mnt/jogos`.
- Adding a game installs only the newly selected game(s).
- Re-running a profile converges to the desired state.
- Destructive operations require explicit human action.
- Steam credentials are never stored in Git.

Expected behavior:

    first run  -> create/configure
    second run -> verify/reconcile
    later run  -> apply only missing changes
