# Architecture

## Overview

The project is divided into three layers.

```text
+-----------------------------+
|       Arch Linux ISO        |
+--------------+--------------+
               |
               v
+-----------------------------+
|          Bootstrap          |
|                             |
| Hardware validation         |
| Disk validation             |
| Partitioning                |
| Btrfs                       |
| Base installation           |
| systemd-boot                |
+--------------+--------------+
               |
               v
+-----------------------------+
|        Installed Arch       |
+--------------+--------------+
               |
               v
+-----------------------------+
|           Ansible           |
|                             |
| System                      |
| Desktop                     |
| Drivers                     |
| Network                     |
| Audio                       |
| Bluetooth                   |
| Gaming                      |
| Applications                |
+--------------+--------------+
               |
               v
+-----------------------------+
|          Validation         |
+-----------------------------+