#!/usr/bin/env bash
set -euo pipefail

# Requires: satty, wl-paste, wl-copy

# Check clipboard has image data
if ! wl-paste --list-types | grep -qE 'image/(png|jpeg|jpg|webp)'; then
  echo "Clipboard doesn't contain an image." >&2
  exit 1
fi

# Dump clipboard image to a temp file
TMP_IN="$(mktemp --suffix=.png)"
TMP_OUT="$(mktemp --suffix=.png)"

# Prefer PNG output regardless of input
wl-paste --type image/png > "$TMP_IN" || {
  # Fallback: try common types then convert via satty (satty reads many formats)
  wl-paste > "$TMP_IN"
}

# Open in Satty; save edits to TMP_OUT, then copy back to clipboard; no permanent file
satty \
  --filename "$TMP_IN" \
  --output-filename "$TMP_OUT" \
  --early-exit \
  --actions-on-enter save-to-clipboard \
  --save-after-copy \
  --copy-command 'wl-copy'

# Clean up temp files
rm -f "$TMP_IN" "$TMP_OUT"
