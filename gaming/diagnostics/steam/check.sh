#!/usr/bin/env bash
set -u
command -v steam >/dev/null && steam --version
distrobox enter gaming -- steam --version
