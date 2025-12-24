#!/usr/bin/uv run

import os
import subprocess

CONFIG_FILE = os.path.expanduser("~/.config/hypr/hyprland.conf")

with open(CONFIG_FILE, "r") as f:
    lines = f.readlines()

uses_laptop = None
for line in lines:
    if line.startswith("# USES_LAPTOP"):
        uses_laptop = "true" in line
        break

new_uses_laptop = not uses_laptop
new_uses_monitors = not new_uses_laptop

output_lines = []
i = 0
while i < len(lines):
    line = lines[i]

    if line.startswith("# USES_LAPTOP"):
        line = f"# USES_LAPTOP = {str(new_uses_laptop).lower()}\n"
        output_lines.append(line)
        i += 1
        if i < len(lines):
            next_line = lines[i]
            if new_uses_laptop:
                next_line = next_line.lstrip("# ")
            else:
                if not next_line.startswith("# "):
                    next_line = "# " + next_line
            output_lines.append(next_line)
    elif line.startswith("# USES_MONITORS"):
        line = f"# USES_MONITORS = {str(new_uses_monitors).lower()}\n"
        output_lines.append(line)
        i += 1
        if i < len(lines):
            next_line = lines[i]
            if new_uses_monitors:
                next_line = next_line.lstrip("# ")
            else:
                if not next_line.startswith("# "):
                    next_line = "# " + next_line
            output_lines.append(next_line)
    elif line.startswith("# monitor=eDP-1, disable"):
        if new_uses_monitors:
            line = line.lstrip("# ")
        else:
            if not line.startswith("# "):
                line = "# " + line
        output_lines.append(line)
    else:
        output_lines.append(line)

    i += 1

with open(CONFIG_FILE, "w") as f:
    f.writelines(output_lines)

subprocess.run(["hyprctl", "reload"])
