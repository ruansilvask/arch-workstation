#!/usr/bin/env bash
set -u
command -v vulkaninfo >/dev/null || exit 1
vulkaninfo --summary
