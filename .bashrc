alias list='ls --ignore="NTUSER*" --ignore="ntuser.*" --ignore="*.dmp"'

RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
PURPLE="\[\e[0;35m\]"
BLUE="\[\e[0;34m\]"
BLACK="\[\e[0;30m\]"
RESET="\[\e[0m\]"

BRIGHT_BLACK="\[\e[1;30m\]"
BRIGHT_RED="\[\e[1;31m\]"
BRIGHT_GREEN="\[\e[1;32m\]"
BRIGHT_BLUE="\[\e[1;34m\]"
BRIGHT_PURPLE="\[\e[1;35m\]"

function get_stds {
    # get both stdout and stderr to a single string
    TMP=$(mktemp)
    $1 >>"$TMP" 2>&1
    cat "$TMP"
    rm "$TMP"
}

function set_window_title {
    echo -ne "\033]0;$@\007"
}

function is_ssh {
    if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        return 0
    fi
    return 1
}

function light_prompt {
    local EXIT=$?
    trap '
    if [[ "$IS_USER_COMMAND" -eq 1 ]] && [[ "$BASH_COMMAND" != "$COMMAND_PROMPT" ]]; then
        IS_USER_COMMAND=0
        set -- $BASH_COMMAND
        set_window_title "$1 @ $(dirs +0)"
    fi
    ' DEBUG
    PS1="$BRIGHT_BLACK\j$RESET"
    PS1="$PS1 $BLUE\w$RESET"
    if is_ssh; then
        PS1="$BRIGHT_BLACK[ssh]$RESET $PS1"
    fi
    if [[ $EXIT == "0" ]]; then
        PS1="$PS1$BRIGHT_GREEN"
    else
        PS1="$PS1$BRIGHT_RED"
    fi
    PS1="$PS1 →$RESET "
    IS_USER_COMMAND=1
}

PROMPT_COMMAND=light_prompt

shopt -s autocd dotglob globstar

# insensitive case path completion in bash
bind 'set completion-ignore-case on'

# this makes the autocompletion propose changes, instead of stopping to the ambiguous characters
bind TAB:menu-complete

alias s="source ~/.bashrc"
alias ls="list -X -F --color=auto"
alias ll="ls -lh"
alias cls="echo -e '\\0033\\0143'"
alias findhere="find . -name"
alias grep="grep -i --color=auto"
alias v="vim ~/dotfiles/.vimrc"
alias b="vim ~/dotfiles/.bashrc"
alias j="jobs"
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

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export HISTCONTROL=ignoreboth:erasedups
export SHELL
export GOPATH="$HOME/gopackages/"
export FCEDIT="vim"
export EDITOR="vim"

# set ls colors
if [[ -f ~/dotfiles/.dircolors ]]; then
    eval `dircolors ~/dotfiles/.dircolors`
fi


if [[ -f ./git-completions.bash ]]; then
    source ./git-completions.bash
fi

source ~/dotfiles/ssh-agent-manager.sh

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="node_modules/.bin/:$PATH"
export PATH="../node_modules/.bin/:$PATH"
