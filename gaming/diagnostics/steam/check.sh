#!/usr/bin/env bash
set -u
if distrobox list | grep -q '\bgaming\b'; then
  distrobox enter gaming -- steam --version
else
  echo "gaming container does not exist"
  exit 1
fi
