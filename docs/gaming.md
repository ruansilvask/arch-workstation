# Gaming implementation

The implementation is adapted from the real Ansible/Distrobox structure of
AkitaOnRails/distrobox-gaming. The reference project is retained under
`gaming/ansible/reference` for provenance and comparison.

The adapted implementation is intentionally narrower:

- AMD instead of NVIDIA
- Omarchy/Wayland instead of a generic desktop target
- Steam-focused
- selected games
- external persistent library
- automated diagnostics/remediation

The reference project is not executed wholesale.
