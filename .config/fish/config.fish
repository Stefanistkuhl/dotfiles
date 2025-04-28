set fish_greeting ""
# figlet -n "oida" | cowsay -n
set -x EDITOR nvim

if status is-interactive
    alias clock='tty-clock -sc'
    alias neovim='nvim'
    alias v='nvim'
    alias vim='nvim'
    alias vd='cd /home/stefiii/dotfiles && nvim .'
    alias history='history 1'
    alias ff='hyfetch -b fastfetch'
    alias :3='hyfetch -b fastfetch'
    alias yay='paru'
    zoxide init --cmd cd fish | source
    starship init fish | source
    alias putty='sudo cu -l /dev/ttyUSB0 -s 9600'
    alias ls='eza'
    alias t='tmux attach -t blank || tmux new-session -s blank'
    alias ga='git add'
    alias coom='git coomit'
    # skim_key_bindings
end
