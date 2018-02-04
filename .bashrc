RESET="\e[0m"

BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
PURPLE="\e[0;35m"
AQUA="\e[0;36m"
WHITE="\e[0;37m"

BRIGHT_BLACK="\e[1;30m"
BRIGHT_RED="\e[1;31m"
BRIGHT_GREEN="\e[1;32m"
BRIGHT_YELLOW="\e[1;33m"
BRIGHT_BLUE="\e[1;34m"
BRIGHT_PURPLE="\e[1;35m"
BRIGHT_AQUA="\e[1;36m"
BRIGHT_WHITE="\e[1;37m"

function get_stds {
    # get both stdout and stderr to a single string
    TMP=$(mktemp)
    $1 >>"$TMP" 2>&1
    cat "$TMP"
    rm "$TMP"
}

function window_title {
    echo -ne "\033]0;$(history | awk 'END {print $2}')@${PWD/*\//}\007"
}

window_title

function is_ssh {
    if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        return 0
    fi
    return 1
}

function light_prompt {
    window_title
    local EXIT=$?
    PS1="\[$BRIGHT_BLACK\]\j\[$RESET\]"
    PS1="$PS1 \[$BLUE\]\w\[$RESET\]"
    if is_ssh; then
        PS1="\[$BRIGHT_BLACK\][ssh]\[$RESET\] $PS1"
    fi
    if [[ $EXIT == "0" ]]; then
        PS1="$PS1\[$BRIGHT_GREEN\]"
    else
        PS1="$PS1\[$BRIGHT_RED\]"
    fi
    PS1="$PS1 →\[$RESET\] "
}

PROMPT_COMMAND=light_prompt

shopt -s autocd dotglob globstar

# insensitive case path completion in bash
bind 'set completion-ignore-case on'

# this makes the autocompletion propose changes, instead of stopping to the ambiguous characters
bind TAB:menu-complete

alias s="source ~/.bashrc"
alias which="which --all"
alias ls="ls -X -F --color=auto"
alias la="ls -A"
alias ll="ls -lh"
alias lla="ll -a"
alias ip="ip -c" # adds color
alias grep="grep -i --color=auto"
alias vimrc="vim ~/dotfiles/.vimrc"
alias bashrc="vim ~/dotfiles/.bashrc"
alias fdf="fd --type f"
alias getmod="stat -c '%a %n'"
alias todo="~/go/act/act -file=~/act"
alias path='echo "$PATH" | tr ":" "\n"'
alias deploy="./deploy.sh --quiet"

function showcolors {
    for i in `seq 0 1`; do
        for e in `seq 30 37` `seq 40 47`; do
            if [[ $e -eq 40 ]]; then
                echo
            fi
            echo -en "\e[$i;${e}m\\\\e[$i;${e}m$RESET "
        done
        echo 
    done
}

function license {
    if [[ ! -d ~/.licenses ]] || [[ ! -f "$HOME/.licenses/$1" ]]; then
        echo "The file '~/.licenses/$1' doesn't exists"
        return 1
    fi
    cp "$HOME/.licenses/$1" LICENSE
}

function mkcd() {
    mkdir -p "$@" && cd "$@"
}

function bgrun {
    $@ > /dev/null 2>&1 &
}

alias mit='license MIT'
alias live-serve='browser-sync start --files "**/*.html, **/*.css, **/*.js" --no-notify --no-open --server'
alias live-serve-bg='bgrun browser-sync start --server --files "**/*.html, **/*.css, **/*.js" --no-notify'

# git alias

alias gs="git status --short"
alias gml="git log --oneline --decorate --all --tags --graph --date-order -10"
alias gl="git log --oneline --decorate --tags --graph --date-order -10"
alias act="~/go/act/act"

# shortcut

# bind -x '"\C-f": "ls"'
bind -x '"\C-f": "xclip -o"'

# exported variables

export HISTCONTROL=ignoreboth:erasedups
export FCEDIT="vim"
export EDITOR="vim"
export FZF_DEFAULT_COMMAND='fd --type f'

# set ls colors
if [[ -f ~/dotfiles/.dircolors ]]; then
    eval `dircolors ~/dotfiles/.dircolors`
fi

source ~/dotfiles/ssh-agent-manager.sh

export PATH="node_modules/.bin/:$PATH"
export PATH="../node_modules/.bin/:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
