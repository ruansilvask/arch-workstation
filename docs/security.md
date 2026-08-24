# Security and secrets

This repository must never contain:

- SSH private keys
- Steam passwords
- Steam Guard codes
- GitHub tokens
- Bitwarden vault data
- Proton VPN credentials
- API keys
- `.env` files containing secrets

SSH public configuration is safe to keep in the repository.

The private key `~/.ssh/id_ed25519` is only loaded if it already exists on the
machine. The bootstrap never generates or copies a private key from the
repository.

Steam game installation requires an authenticated Steam session. The
repository does not store Steam credentials.
