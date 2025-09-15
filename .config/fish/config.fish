set fish_greeting ""
# figlet -n "oida" | cowsay -n
set -x EDITOR nvim
set -x GOPATH ~/.go

if status is-interactive

    zoxide init --cmd cd fish | source
    starship init fish | source
    atuin init fish --disable-up-arrow | source

    abbr ip 'ip -c'
    alias owo='sudo'
    alias uwu='sudo'
    alias pwease='sudo'
    alias upload='fish ~/dotfiles/.config/fish/thing.fish -u'
    alias download='fish ~/dotfiles/.config/fish/thing.fish'
    alias clock='tty-clock -sc'
    alias neovim='nvim'
    alias v='nvim'
    alias vim='nvim'
    alias vd='cd /home/stefiii/dotfiles && nvim .'
    alias ff='hyfetch'
    alias :3='hyfetch'
    alias yay='paru'
    alias putty='sudo cu -l /dev/ttyUSB0 -s 9600'
    alias ls='eza'
    alias t='bash -c "~/dotfiles/.config/tmux/tmux_startup.sh"'
    alias ga='git add'
    alias glog='git log'
    alias gs='git status'
    alias gd='git diff --stat'
    alias cat='bat'
end
