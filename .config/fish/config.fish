set fish_greeting ""
# figlet -n "oida" | cowsay -n
set -x EDITOR nvim
set -x GOPATH ~/.go

if status is-interactive

    zoxide init --cmd cd fish | source
    starship init fish | source

    alias clock='tty-clock -sc'
    alias neovim='nvim'
    alias v='nvim'
    alias vim='nvim'
    alias vd='cd /home/stefiii/dotfiles && nvim .'
    alias ff='hyfetch -b fastfetch'
    alias :3='hyfetch -b fastfetch'
    alias yay='paru'
    alias putty='sudo cu -l /dev/ttyUSB0 -s 9600'
    alias ls='eza'
    alias t='tmux attach -t blank || tmux new-session -s blank'
    alias ga='git add'
    alias coom='git coomit'
    alias cum='git commit'
    alias glog='git log'
    alias gs='git status'
    alias gd='git diff --stat'
    alias gr='git reset --hard HEAD'
    alias cummies='git push'
    alias booba='git pull'
    alias dcps="nu -c 'docker compose ps | detect columns'"
    alias dps="nu -c 'docker ps | detect columns'"
    # skim_key_bindings
end
