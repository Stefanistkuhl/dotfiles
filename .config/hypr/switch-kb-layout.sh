#!/bin/bash

CONFIG_FILE="/home/stefiii/dotfiles/.config/hypr/hyprland.conf"

KB_LAYOUT=$(sed -n 's/^\s*kb_layout\s*=\s*//p' "$CONFIG_FILE" | head -n 1)

if [ -z "$KB_LAYOUT" ]; then
  echo "Error: kb_layout not found or value is empty in $CONFIG_FILE" >&2
  exit 1
fi

if [ "$KB_LAYOUT" = "en" ]; then
  sed -i "s/kb_layout *= *en/kb_layout = de/g" "$CONFIG_FILE"
fi

if [ "$KB_LAYOUT" = "de" ]; then
  sed -i "s/kb_layout *= *de/kb_layout = en/g" "$CONFIG_FILE"
fi
