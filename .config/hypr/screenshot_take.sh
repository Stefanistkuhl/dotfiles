#!/usr/bin/env bash
set -euo pipefail

# Requires: grim, slurp, wl-copy
# Always region; clipboard only

TMP_PNG="$(mktemp --suffix=.png)"
cleanup() { rm -f "$TMP_PNG"; }
trap cleanup EXIT

# Select region (slurp draws the overlay and effectively freezes view during selection)
GEOM="$(slurp)" || {
  echo "Selection canceled." >&2
  exit 1
}

# Capture the selected region
grim -g "$GEOM" "$TMP_PNG" >/dev/null 2>&1

# Ensure file has data
if [[ ! -s "$TMP_PNG" ]]; then
  echo "grim produced an empty image file." >&2
  exit 1
fi

# Copy to clipboard as PNG
wl-copy --type image/png <"$TMP_PNG"
