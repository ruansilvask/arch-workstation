# Ansible

This directory will contain the post-installation configuration.

Ansible will configure the installed Arch Linux system after the bootstrap phase.

Planned roles:

- base
- kernel
- network
- nvidia
- kde
- audio
- bluetooth
- gaming
- steam
- applications

The Ansible layer must be idempotent whenever possible.

Running the playbook multiple times should converge the machine toward the desired configuration without unnecessarily changing already-correct settings.