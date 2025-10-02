#!/usr/bin/env bash
set -euo pipefail

OUTPUT_DIR="${OUTPUT_DIR:-$HOME/Pictures/Screenshots}"
mkdir -p "$OUTPUT_DIR"

pkill -x slurp || true

MODE="${1:-region}"  # region | window | output
STAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
OUT="$OUTPUT_DIR/screenshot-$STAMP.png"

# Take shot (freeze screen), pipe raw to satty for quick edits, save, and copy
hyprshot -m "$MODE" --freeze --raw \
  | satty --filename - \
      --output-filename "$OUT" \
      --early-exit \
      --actions-on-enter save-to-clipboard \
      --save-after-copy \
      --copy-command 'wl-copy'

