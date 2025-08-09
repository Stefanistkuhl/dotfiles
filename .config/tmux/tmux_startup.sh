#!/bin/bash
# tmux attach -t blank || tmux new-session -s blank

# if ! pgrep -x tmux >/dev/null; then
#     tmux new-session -d -s __restore_trigger
#     sleep 0.5
#     tmux kill-session -t __restore_trigger 2>/dev/null
# fi

session=$(sesh list --icons | fzf --ansi --no-sort --border-label ' sesh ' --prompt '🤓 ' --preview 'sesh preview {}')
[ -n "$session" ] && sesh connect "$session"
