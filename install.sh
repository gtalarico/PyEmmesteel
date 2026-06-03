#!/usr/bin/env bash
#
# Deploy the emmesteel custom component to a Home Assistant install.
#
# Syncs ./home-assistant/ -> <HOST>:/config/custom_components/emmesteel/
# over SSH. The target dir is root-owned, so we rsync via `sudo rsync`
# on the remote (requires passwordless sudo for the SSH user).
#
# Usage:
#   ./install.sh                 # uses default host below
#   ./install.sh user@my-ha-box  # override host
#
# After it runs, restart Home Assistant for the component to (re)load.

set -euo pipefail

HOST="${1:-homeassistant.local}"
SRC="$(cd "$(dirname "$0")" && pwd)/home-assistant/"
DEST="/config/custom_components/emmesteel/"

echo "Deploying emmesteel -> ${HOST}:${DEST}"

rsync -avz \
  --rsync-path="sudo rsync" \
  --exclude='__pycache__' \
  "${SRC}" "${HOST}:${DEST}"

echo
echo "Done. Now restart Home Assistant for the changes to load:"
echo "  Settings -> System -> Restart   (or Developer Tools -> Restart)"
