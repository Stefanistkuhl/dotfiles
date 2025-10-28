#!/usr/bin/env fish
cat ~/.local/share/bemoji/emojis.txt | tofi --prompt " emoji: " | awk '{print $1}' | tr -d '\n' | wl-copy
