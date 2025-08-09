set fish_greeting ""
# figlet -n "oida" | cowsay -n
set -x EDITOR nvim
set -x GOPATH ~/.go

if status is-interactive

    zoxide init --cmd cd fish | source
    starship init fish | source
    atuin init fish --disable-up-arrow | source

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
    alias t='bash -c "~/dotfiles/.config/tmux/tmux_startup.sh"'
    alias ga='git add'
    alias coom='git coomit'
    alias cum='git commit'
    alias glog='git log'
    alias gs='git status'
    alias gd='git diff --stat'
    alias gr='git reset --hard HEAD'
    alias cummies='git push'
    alias booba='git pull'
    alias cat='bat'
    # alias dcps="nu -c 'docker compose ps | detect columns'"
    # alias dps="nu -c 'docker ps | detect columns'"
    # alias nji="nu --stdin -c 'from json | explore -i'"
    # alias nj="nu --stdin -c 'from json'"
    # alias nyi="nu --stdin -c 'from yml | explore -i'"
    # alias ny="nu --stdin -c 'from yml'"
    # alias nui="nu --stdin -c 'from url | explore -i'"
    # alias nu="nu --stdin -c 'from url'"
    # alias nti="nu --stdin -c 'from toml | explore -i'"
    # alias nt="nu --stdin -c 'from toml'"
    # skim_key_bindings
    alias dcub='docker compose up -d --build'
    alias ddcub='docker compose down && docker compose up -d --build'
    alias ddcu='docker compose down && docker compose up -d'
    alias dcu='docker compose up -d'
    alias dcl='docker compose logs'
    alias dcd='docker compose down'
end
